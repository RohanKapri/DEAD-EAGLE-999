
UPDATE "all-your-base" SET result = (CASE
  WHEN input_base < 2 THEN '{"error":"input base must be >= 2"}'
  WHEN output_base < 2 THEN '{"error":"output base must be >= 2"}'
  WHEN (SELECT EXISTS (
    SELECT 1 FROM json_each(digits)
    WHERE value NOT BETWEEN 0 AND input_base - 1))
  THEN '{"error":"all digits must satisfy 0 <= d < input base"}' ELSE (
    WITH RECURSIVE
      _in(i, m) AS (
	VALUES (0, 0) UNION ALL
	SELECT i + 1, m * input_base + (digits ->> i)
	FROM _in WHERE i < json_array_length(digits)),
      _out(s, n) AS (
	SELECT '', m FROM _in WHERE i = json_array_length(digits)
	UNION ALL SELECT
	  iif(s = '', format('%d', n % output_base),
	      format('%d,%s', n % output_base, s)),
	  n / output_base FROM _out WHERE n > 0)
    SELECT format('{"digits":[%s]}', iif(s = '', '0', s))
    FROM _out WHERE n = 0) END);