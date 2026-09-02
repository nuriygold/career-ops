#!/usr/bin/env node
import assert from 'node:assert/strict';
import test from 'node:test';
import {
  projectTrackerRows,
  deriveFollowup,
  indexByTrackerNumber,
  compareProjections,
} from './tracker-sheet-sync-core.mjs';

const rows = [
  { num: '55', date: '2026-09-02', company: 'Smartsheet', role: 'Director', score: '4.1/5', status: 'Applied', report: '-', notes: 'Application submitted.' },
  { num: '40', date: '2026-08-28', company: 'Cohere', role: 'Policy Manager', score: 'N/A', status: 'Applied', report: '-', notes: 'Follow-up email sent 2026-08-28.' },
];

test('deriveFollowup recognizes drafted and sent follow-ups', () => {
  assert.equal(deriveFollowup('Follow-up drafted 2026-09-02.'), 'Drafted');
  assert.equal(deriveFollowup('Follow-up email sent 2026-08-28.'), 'Sent');
  assert.equal(deriveFollowup('No outreach.'), '');
});

test('projectTrackerRows omits PDF and emits the Sheet application columns', () => {
  assert.deepEqual(projectTrackerRows(rows), [
    ['#', 'Date', 'Company', 'Role', 'Score', 'Status', 'Report', 'Follow-up', 'Notes'],
    ['55', '2026-09-02', 'Smartsheet', 'Director', '4.1/5', 'Applied', '-', '', 'Application submitted.'],
    ['40', '2026-08-28', 'Cohere', 'Policy Manager', 'N/A', 'Applied', '-', 'Sent', 'Follow-up email sent 2026-08-28.'],
  ]);
});

test('indexByTrackerNumber provides stable identity independent of row position', () => {
  const index = indexByTrackerNumber(projectTrackerRows(rows));
  assert.equal(index.get('55')[2], 'Smartsheet');
  assert.equal(index.get('40')[2], 'Cohere');
});

test('compareProjections reports changed cells and row additions', () => {
  const actual = projectTrackerRows(rows);
  actual[1][5] = 'Interview';
  actual.push(['60', '2026-09-03', 'NewCo', 'Role', '4.0/5', 'Applied', '-', '', '']);
  const result = compareProjections(projectTrackerRows(rows), actual);
  assert.deepEqual(result.changed, [{ trackerNumber: '55', column: 'Status', expected: 'Applied', actual: 'Interview' }]);
  assert.deepEqual(result.unexpectedRows, ['60']);
  assert.deepEqual(result.missingRows, []);
});
