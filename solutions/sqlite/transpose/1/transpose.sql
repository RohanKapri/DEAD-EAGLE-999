UPDATE transpose
SET result = (
  WITH
    lines(t, l) AS (
      SELECT lines || char(10), '' UNION ALL
      SELECT substr(t, instr(t, char(10)) + 1), substr(t, 1, instr(t, char(10)) - 1)
      FROM lines
      WHERE t != ''
    ),
    transposed(i, x) AS (
      SELECT 1, '' UNION ALL
      SELECT i + 1, rtrim((SELECT IFNULL(group_concat(IIF(i <= length(l), substr(l, i, 1), char(1)), ''), '') FROM lines WHERE l != ''), char(1))
      FROM transposed
      WHERE i < 2 OR x != ''
    )
  SELECT IFNULL(group_concat(replace(x, char(1), ' '), char(10)) FILTER (WHERE x != ''), '')
  FROM transposed
)