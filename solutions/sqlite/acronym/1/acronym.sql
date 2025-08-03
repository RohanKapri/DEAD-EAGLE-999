-- Schema: CREATE TABLE acronym ( phrase TEXT PRIMARY KEY, result TEXT );
-- Task: update the acronym table and set the result based on the phrase.
UPDATE acronym SET result = (
  WITH RECURSIVE
    _1(s, j) AS (
      VALUES ('', 1) UNION ALL
      SELECT s || CASE
	WHEN substr(phrase, j, 1) = '''' THEN ''
	WHEN substr(phrase, j, 1) GLOB '[A-Za-z]'
	THEN upper(substr(phrase, j, 1)) ELSE ' ' END, j + 1
      FROM _1 WHERE j <= length(phrase)),
    _2(n, r, i) AS (
      SELECT length(s), '', 1 FROM _1 WHERE j > length(phrase) UNION ALL
      SELECT n, r || iif(
	i > 1 AND substr(s, i - 1, 1) != ' ' OR substr(s, i, 1) = ' ',
	'', substr(s, i, 1)), i + 1
      FROM _1 JOIN _2 ON j > length(phrase) AND i <= n)
  SELECT r FROM _2 WHERE i > n);