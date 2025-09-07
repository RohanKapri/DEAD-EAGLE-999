UPDATE "reverse-string"
SET result = (
  WITH reverse(i, c) AS (
    values(-1, '')
    UNION ALL SELECT i - 1, substr(input, i, 1) AS r FROM reverse
    WHERE r != ''
  ) SELECT group_concat(c, '') FROM reverse
);