UPDATE diamond
SET result = (
  WITH nums(n, i) AS (
    SELECT 65, 1 UNION
    SELECT n + i, i - (n + i == unicode(letter)) * 2
    FROM nums
    WHERE letter != 'A' AND n * i != -65
  )
  SELECT
    group_concat((
      SELECT group_concat(iif(unicode(letter) - b.n + 65 = a.n, char(a.n), ' '), '')
      FROM nums b
    ), char(10))
  FROM nums a
);