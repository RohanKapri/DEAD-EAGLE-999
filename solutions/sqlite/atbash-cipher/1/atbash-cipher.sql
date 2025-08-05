
UPDATE "atbash-cipher" SET result = (
  WITH RECURSIVE
    _1(i, s) AS (VALUES (0, '') UNION ALL SELECT i + 1, s || CASE
      WHEN substr(phrase, i, 1) GLOB '[0-9]' THEN substr(phrase, i, 1)
      WHEN substr(phrase, i, 1) GLOB '[A-Z]'
      THEN char(187 - unicode(substr(phrase, i, 1)))
      WHEN substr(phrase, i, 1) GLOB '[a-z]'
      THEN char(219 - unicode(substr(phrase, i, 1)))
      ELSE '' END FROM _1 WHERE i <= length(phrase)),
    _2(s) AS (SELECT s FROM _1 WHERE i > length(phrase)),
    _3(i, t) AS (VALUES (0, '') UNION ALL SELECT
      i + 1, t || iif(i > 0 AND i % 5 = 0, ' ', '') ||
      substr(s, i + 1, 1) FROM _2 JOIN _3 ON i < length(s))
  SELECT iif(property = 'encode', t, s)
  FROM _2 JOIN _3 ON i = length(s));