#!/usr/bin/env node

const COLUMNS = ['#', 'Date', 'Company', 'Role', 'Score', 'Status', 'Report', 'Follow-up', 'Notes'];

export function normalizeCell(value) {
  return String(value ?? '').replace(/\r\n?/g, '\n').trim();
}

export function deriveFollowup(notes) {
  const text = normalizeCell(notes);
  if (/follow-up(?:\s+email)?(?:\s+\w+)?\s+sent\s+\d{4}-\d{2}-\d{2}/i.test(text)) return 'Sent';
  if (/follow-up\s+drafted\s+\d{4}-\d{2}-\d{2}/i.test(text)) return 'Drafted';
  return '';
}

export function projectTrackerRows(trackerRows) {
  if (!Array.isArray(trackerRows)) throw new TypeError('trackerRows must be an array');
  return [
    COLUMNS,
    ...trackerRows.map((row) => [
      normalizeCell(row.num), normalizeCell(row.date), normalizeCell(row.company),
      normalizeCell(row.role), normalizeCell(row.score), normalizeCell(row.status),
      normalizeCell(row.report), deriveFollowup(row.notes), normalizeCell(row.notes),
    ]),
  ];
}

export function indexByTrackerNumber(rows) {
  if (!Array.isArray(rows) || !Array.isArray(rows[0])) throw new TypeError('rows must include a header row');
  const numberIndex = rows[0].indexOf('#');
  if (numberIndex < 0) throw new Error('projection is missing # column');
  const index = new Map();
  for (const row of rows.slice(1)) {
    const number = normalizeCell(row[numberIndex]);
    if (number) index.set(number, row);
  }
  return index;
}

export function compareProjections(expected, actual) {
  if (!Array.isArray(expected) || !Array.isArray(actual)) throw new TypeError('projections must be arrays');
  const expectedRows = indexByTrackerNumber(expected);
  const actualRows = indexByTrackerNumber(actual);
  const columns = expected[0] || COLUMNS;
  const changed = [];
  const missingRows = [];
  const unexpectedRows = [];

  for (const [number, expectedRow] of expectedRows) {
    const actualRow = actualRows.get(number);
    if (!actualRow) {
      missingRows.push(number);
      continue;
    }
    for (let i = 0; i < columns.length; i++) {
      const expectedCell = normalizeCell(expectedRow[i]);
      const actualCell = normalizeCell(actualRow[i]);
      if (expectedCell !== actualCell) {
        changed.push({ trackerNumber: number, column: columns[i], expected: expectedCell, actual: actualCell });
      }
    }
  }
  for (const number of actualRows.keys()) {
    if (!expectedRows.has(number)) unexpectedRows.push(number);
  }
  return { changed, missingRows, unexpectedRows };
}

export function hasDrift(result) {
  return result.changed.length > 0 || result.missingRows.length > 0 || result.unexpectedRows.length > 0;
}
