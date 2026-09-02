#!/usr/bin/env node

import { readFileSync, existsSync } from 'node:fs';
import { resolve } from 'node:path';
import { resolveColumns, parseTrackerRow } from './tracker-parse.mjs';
import { resolveTrackerPath } from './tracker-utils.mjs';
import { projectTrackerRows, compareProjections, hasDrift, normalizeCell } from './tracker-sheet-sync-core.mjs';

const ROOT = process.cwd();
const DEFAULT_TAB = 'applications-tracker-2026-08-07';
const DEFAULT_RANGE = 'A:I';
const DEFAULT_TRACKER_URL = 'https://docs.google.com/spreadsheets/d/1LmSKW1kaDdbcJWmC087w9W_-gGqCiwh-2TOmt9kXci0/edit';
const TOKEN_URL = 'https://oauth2.googleapis.com/token';
const SHEETS_API = 'https://sheets.googleapis.com/v4/spreadsheets';

function loadDotEnv() {
  const env = { ...process.env };
  if (!existsSync(resolve('.env'))) return env;
  for (const line of readFileSync(resolve('.env'), 'utf8').split(/\r?\n/)) {
    const match = line.match(/^([A-Z][A-Z0-9_]*)=(.*)$/);
    if (match && env[match[1]] == null) env[match[1]] = match[2].replace(/^['"]|['"]$/g, '');
  }
  return env;
}

export function parseSpreadsheetId(value) {
  const input = String(value ?? '').trim();
  const match = input.match(/\/spreadsheets\/d\/([a-zA-Z0-9_-]+)/);
  if (match) return match[1];
  if (/^[a-zA-Z0-9_-]{10,}$/.test(input)) return input;
  throw new Error('GOOGLE_SHEETS_TRACKER_URL must be a Google Sheets URL or spreadsheet ID');
}

export function sheetsRange(tab, range = DEFAULT_RANGE) {
  const safeTab = String(tab ?? '').trim();
  if (!safeTab || /[\r\n]/.test(safeTab)) throw new Error('Google Sheets tab name is invalid');
  if (!/^[A-Z]+(?::[A-Z]+)?$/.test(range)) throw new Error('Google Sheets range must be a bounded column range such as A:I');
  return `'${safeTab.replace(/'/g, "''")}'!${range}`;
}

function sheetsRowsRange(tab, startRow, endRow, range = DEFAULT_RANGE) {
  if (!Number.isInteger(startRow) || !Number.isInteger(endRow) || startRow < 1 || endRow < startRow) throw new Error('Google Sheets row bounds are invalid');
  const endColumn = String(range).split(':').at(-1);
  if (!/^[A-Z]+$/.test(endColumn)) throw new Error('Google Sheets range must end with a column letter');
  return `'${String(tab).replace(/'/g, "''")}'!A${startRow}:${endColumn}${endRow}`;
}

export function loadConfig(env = loadDotEnv()) {
  const trackerUrl = env.GOOGLE_SHEETS_TRACKER_URL || DEFAULT_TRACKER_URL;
  const config = {
    clientId: env.GOOGLE_SHEETS_CLIENT_ID || env.GMAIL_CLIENT_ID || '',
    clientSecret: env.GOOGLE_SHEETS_CLIENT_SECRET || env.GMAIL_CLIENT_SECRET || '',
    refreshToken: env.GOOGLE_SHEETS_REFRESH_TOKEN || '',
    spreadsheetId: parseSpreadsheetId(trackerUrl),
    tab: env.GOOGLE_SHEETS_TRACKER_TAB || DEFAULT_TAB,
    range: env.GOOGLE_SHEETS_TRACKER_RANGE || DEFAULT_RANGE,
  };
  return config;
}

function requireCredentials(config) {
  const missing = ['clientId', 'clientSecret', 'refreshToken'].filter((key) => !config[key]);
  if (missing.length) throw new Error(`Missing Google Sheets credentials: ${missing.join(', ')}. Run node sheets-oauth-setup.mjs first.`);
}

export function createSheetsClient({ config, fetchImpl = globalThis.fetch }) {
  requireCredentials(config);
  if (typeof fetchImpl !== 'function') throw new Error('fetch is unavailable; use Node.js 18 or newer');
  let accessToken;

  async function request(url, options = {}) {
    const response = await fetchImpl(url, options);
    const text = await response.text();
    let body;
    try { body = text ? JSON.parse(text) : {}; } catch { body = { raw: text }; }
    if (!response.ok) throw new Error(`Google Sheets API ${response.status}: ${body.error?.message || body.raw || 'request failed'}`);
    return body;
  }

  async function token() {
    if (accessToken) return accessToken;
    const params = new URLSearchParams({ client_id: config.clientId, client_secret: config.clientSecret, refresh_token: config.refreshToken, grant_type: 'refresh_token' });
    const body = await request(TOKEN_URL, { method: 'POST', headers: { 'Content-Type': 'application/x-www-form-urlencoded' }, body: params.toString() });
    if (!body.access_token) throw new Error('Google OAuth response did not contain an access token');
    accessToken = body.access_token;
    return accessToken;
  }

  async function api(path, options = {}) {
    const access = await token();
    return request(`${SHEETS_API}/${config.spreadsheetId}${path}`, { ...options, headers: { Authorization: `Bearer ${access}`, 'Content-Type': 'application/json', ...(options.headers || {}) } });
  }

  return {
    async read() {
      const range = encodeURIComponent(sheetsRange(config.tab, config.range));
      return api(`/values/${range}`);
    },
    async update(values) {
      const range = encodeURIComponent(sheetsRange(config.tab, config.range));
      return api(`/values/${range}?valueInputOption=RAW`, { method: 'PUT', body: JSON.stringify({ majorDimension: 'ROWS', values }) });
    },
    async clearFromRow(startRow, endRow = 1000) {
      const range = encodeURIComponent(sheetsRowsRange(config.tab, startRow, endRow, config.range));
      return api(`/values/${range}:clear`, { method: 'POST', body: '{}' });
    },
  };
}

function readTrackerRows(trackerPath = resolveTrackerPath(ROOT)) {
  const lines = readFileSync(trackerPath, 'utf8').replace(/\r/g, '').split('\n');
  const columns = resolveColumns(lines);
  return lines.map((line) => parseTrackerRow(line, columns)).filter(Boolean);
}

function trimBlankRows(values) {
  const rows = Array.isArray(values) ? values.map((row) => Array.isArray(row) ? row.map(normalizeCell) : []) : [];
  while (rows.length && rows.at(-1).every((cell) => !cell)) rows.pop();
  return rows;
}

export async function push({ config = loadConfig(), trackerPath } = {}) {
  const expected = projectTrackerRows(readTrackerRows(trackerPath));
  const client = createSheetsClient({ config });
  const result = await client.update(expected);
  const cleared = await client.clearFromRow(expected.length + 1);
  return { rows: expected.length, result, cleared };
}

export async function check({ config = loadConfig(), trackerPath, client } = {}) {
  const expected = projectTrackerRows(readTrackerRows(trackerPath));
  const actualResponse = await (client || createSheetsClient({ config })).read();
  const actual = trimBlankRows(actualResponse.values);
  const drift = compareProjections(expected, actual);
  return { drift, expectedRows: expected.length, actualRows: actual.length, inSync: !hasDrift(drift) };
}

function parseArgs(argv) {
  const mode = argv[0] || 'check';
  const intervalIndex = argv.indexOf('--interval');
  const interval = intervalIndex >= 0 ? Number(argv[intervalIndex + 1]) : 60;
  return { mode, interval: Number.isFinite(interval) && interval > 0 ? interval : 60, repair: argv.includes('--repair') };
}

async function run() {
  const args = parseArgs(process.argv.slice(2));
  if (!['push', 'check', 'watch'].includes(args.mode)) throw new Error('Usage: node tracker-sync.mjs [push|check|watch] [--interval SECONDS] [--repair]');
  const config = loadConfig();
  if (args.mode === 'push') {
    const result = await push({ config });
    console.log(`✅ Google Sheets tracker synchronized (${result.rows - 1} applications).`);
    return;
  }
  if (args.mode === 'check') {
    const result = await check({ config });
    console.log(result.inSync ? '✅ Google Sheets tracker is in sync.' : JSON.stringify(result.drift, null, 2));
    if (!result.inSync) process.exitCode = 2;
    return;
  }
  console.log(`Watching Google Sheets tracker every ${args.interval}s${args.repair ? ' with repair enabled' : ''}. Press Ctrl-C to stop.`);
  const cycle = async () => {
    const result = await check({ config });
    if (result.inSync) console.log(`[${new Date().toISOString()}] in sync`);
    else if (args.repair) { await push({ config }); console.log(`[${new Date().toISOString()}] drift repaired from markdown`); }
    else console.log(`[${new Date().toISOString()}] drift detected: ${JSON.stringify(result.drift)}`);
  };
  await cycle();
  setInterval(() => cycle().catch((error) => console.error(`[${new Date().toISOString()}] sync error: ${error.message}`)), args.interval * 1000);
}

if (import.meta.url === `file://${process.argv[1]}`) run().catch((error) => { console.error(`❌ ${error.message}`); process.exitCode = 1; });
