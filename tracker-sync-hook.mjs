#!/usr/bin/env node

import { execFileSync } from 'node:child_process';
import { dirname } from 'node:path';
import { fileURLToPath } from 'node:url';

const ROOT = dirname(fileURLToPath(import.meta.url));

export function runAutoSync({ env = process.env, rootDir = ROOT, exec = execFileSync } = {}) {
  if (env.CAREER_OPS_SHEETS_SYNC !== '1') return 'disabled';
  try {
    exec('node', ['tracker-sync.mjs', 'push'], { cwd: rootDir, env, stdio: 'inherit' });
    return 'synced';
  } catch (error) {
    console.warn(`⚠️  Google Sheets auto-sync failed: ${error.message}`);
    return 'failed';
  }
}

if (import.meta.url === `file://${process.argv[1]}`) {
  process.exitCode = runAutoSync() === 'failed' ? 1 : 0;
}
