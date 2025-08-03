-- Schema: CREATE TABLE IF NOT EXISTS color_code ( color1 TEXT, color2 TEXT, color3 TEXT, result TEXT );
-- Task: update the color_code table and set the result based on the colors.
WITH
  _c(n, c) AS (VALUES
    (0, 'black'), (1, 'brown'), (2, 'red'), (3, 'orange'),
    (4, 'yellow'), (5, 'green'), (6, 'blue'), (7, 'violet'),
    (8, 'grey'), (9, 'white')),
  _m(m, s) AS (VALUES (0, ''), (1, 'kilo'), (2, 'mega'), (3, 'giga')),
  _1(c1, c2, c3, n) AS (
    SELECT a.c, b.c, c.c, (a.n * 10 + b.n) * pow(10, c.n)
    FROM color_code JOIN _c a JOIN _c b JOIN _c c
    ON a.c = color1 AND b.c = color2 AND c.c = color3),
  _2(n, m) AS (
    SELECT n, CASE
      WHEN n = 0 THEN 0 WHEN n % pow(10, 9) = 0 THEN 3
      WHEN n % pow(10, 6) = 0 THEN 2
      WHEN n % pow(10, 3) = 0 THEN 1 ELSE 0 END
    FROM _1)
UPDATE color_code SET result = (
  SELECT format('%d %sohms', _2.n / pow(10, _2.m * 3), s)
  FROM _1 JOIN _2 JOIN _m ON _1.n = _2.n AND _2.m = _m.m
  AND c1 = color1 AND c2 = color2 AND c3 = color3);