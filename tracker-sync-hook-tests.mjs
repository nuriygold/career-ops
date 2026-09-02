#!/usr/bin/env node
import assert from 'node:assert/strict';
import test from 'node:test';
import { runAutoSync } from './tracker-sync-hook.mjs';

test('automatic sync is disabled unless explicitly enabled', () => {
  const calls = [];
  const result = runAutoSync({ env: {}, exec: (...args) => calls.push(args) });
  assert.equal(result, 'disabled');
  assert.equal(calls.length, 0);
});

test('automatic sync invokes push when enabled', () => {
  const calls = [];
  const result = runAutoSync({ env: { CAREER_OPS_SHEETS_SYNC: '1' }, exec: (...args) => calls.push(args) });
  assert.equal(result, 'synced');
  assert.deepEqual(calls[0][0], 'node');
  assert.deepEqual(calls[0][1], ['tracker-sync.mjs', 'push']);
});

test('automatic sync reports failure without throwing', () => {
  const result = runAutoSync({ env: { CAREER_OPS_SHEETS_SYNC: '1' }, exec: () => { throw new Error('offline'); } });
  assert.equal(result, 'failed');
});
