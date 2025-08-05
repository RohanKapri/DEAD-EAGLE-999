
UPDATE anagram SET result = (
  WITH
    _1(s, l) AS (
      VALUES (subject, lower(subject)) UNION ALL
      SELECT value, lower(value) FROM json_each(candidates)
      WHERE length(value) = length(subject)
      AND lower(value) != lower(subject)),
    _2(s, t) AS (SELECT s, (
      WITH
	_3(c) AS (
	  SELECT substr(l, i.value, 1)
	  FROM generate_series(0, length(l)) AS i),
	_4(c) AS (SELECT * FROM _3 ORDER BY c)
      SELECT group_concat(c, '') FROM _4) FROM _1)
  SELECT json_group_array(b.s) FROM _2 a JOIN _2 b
  ON a.s = subject AND b.s != a.s AND b.t = a.t);