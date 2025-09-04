ALTER TABLE "crypto-square" ADD clean TEXT;
UPDATE "crypto-square"
SET clean = (
  WITH cleaned(s, c) AS (
    SELECT plaintext, '' UNION
    SELECT substr(s, 2), IIF(s GLOB '[a-zA-Z0-9]*', lower(substr(s, 1, 1)), '')
    FROM cleaned
    WHERE s != ''
  )
  SELECT group_concat(c, '') FROM cleaned
);
UPDATE "crypto-square"
SET result = (
  SELECT (
    WITH lines(i, s) AS (
      SELECT 0, '' UNION
      SELECT i + 1, (
        WITH chars(j, x) AS (
          SELECT 0, '' UNION
          SELECT j + 1, substr(substr(clean, j * c + i + 1, 1) || ' ', 1, 1)
          FROM chars
          WHERE j < r
        )
        SELECT group_concat(x, '') FROM chars
      )
      FROM lines
      WHERE i < c
    )
    SELECT IFNULL(group_concat(s, ' ') FILTER (WHERE s != ''), '')
    FROM lines
  ) FROM (
    SELECT
      cast(round(sqrt(length(clean))) as integer) r,
      cast(ceiling(sqrt(length(clean))) as integer) c
  )
);