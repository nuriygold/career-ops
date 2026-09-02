#!/usr/bin/env node
import assert from 'node:assert/strict';
import test from 'node:test';
import { loadConfig, parseSpreadsheetId, sheetsRange, createSheetsClient } from './tracker-sync.mjs';

test('parseSpreadsheetId accepts a Google Sheets URL', () => {
  assert.equal(parseSpreadsheetId('https://docs.google.com/spreadsheets/d/abc123/edit#gid=4'), 'abc123');
});

test('loadConfig reads environment and defaults application range to A:I', () => {
  const config = loadConfig({
    GOOGLE_SHEETS_CLIENT_ID: 'id',
    GOOGLE_SHEETS_CLIENT_SECRET: 'secret',
    GOOGLE_SHEETS_REFRESH_TOKEN: 'refresh',
    GOOGLE_SHEETS_TRACKER_URL: 'https://docs.google.com/spreadsheets/d/sheet123/edit',
  });
  assert.equal(config.spreadsheetId, 'sheet123');
  assert.equal(config.tab, 'applications-tracker-2026-08-07');
  assert.equal(config.range, 'A:I');
});

test('sheetsRange quotes tab names and confines updates to application columns', () => {
  assert.equal(sheetsRange('applications-tracker-2026-08-07', 'A:I'), "'applications-tracker-2026-08-07'!A:I");
});

test('client updates values with Sheets API and rejects unsuccessful responses', async () => {
  const calls = [];
  const client = createSheetsClient({
    config: { spreadsheetId: 'sheet123', tab: 'Applications', range: 'A:I', clientId: 'id', clientSecret: 'secret', refreshToken: 'refresh' },
    fetchImpl: async (url, options) => {
      calls.push({ url, options });
      if (url.includes('/token')) return new Response(JSON.stringify({ access_token: 'access' }), { status: 200 });
      return new Response(JSON.stringify({ updatedRows: 2 }), { status: 200 });
    },
  });
  const result = await client.update([["#", "Date"], ["1", "2026-09-02"]]);
  assert.equal(result.updatedRows, 2);
  assert.match(calls[1].url, /valueInputOption=RAW/);
  assert.equal(JSON.parse(calls[1].options.body).values[1][0], '1');
});

test('client clears stale application rows without touching other columns', async () => {
  const calls = [];
  const client = createSheetsClient({
    config: { spreadsheetId: 'sheet123', tab: 'Applications', range: 'A:I', clientId: 'id', clientSecret: 'secret', refreshToken: 'refresh' },
    fetchImpl: async (url, options) => {
      calls.push({ url, options });
      if (url.includes('/token')) return new Response(JSON.stringify({ access_token: 'access' }), { status: 200 });
      return new Response(JSON.stringify({ clearedRange: "'Applications'!A4:I1000" }), { status: 200 });
    },
  });
  const result = await client.clearFromRow(4, 1000);
  assert.equal(result.clearedRange, "'Applications'!A4:I1000");
  assert.match(calls[1].url, /:clear$/);
  assert.equal(calls[1].options.method, 'POST');
});
