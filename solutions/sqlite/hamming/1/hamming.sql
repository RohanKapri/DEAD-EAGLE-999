UPDATE hamming
SET error = "strands must be of equal length";
UPDATE hamming
SET
  error = NULL,
  result = (
    WITH RECURSIVE count(a, b) AS (
      VALUES(strand1, strand2)
      UNION ALL
      SELECT substr(a, 2), substr(b, 2)
      FROM count
      WHERE a != ''
    )
    SELECT SUM(substr(a, 1, 1) != substr(b, 1, 1))
    FROM count
  )
WHERE length(strand1) = length(strand2);