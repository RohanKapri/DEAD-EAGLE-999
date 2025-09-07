UPDATE "largest-series-product" SET error = CASE
    WHEN span < 0 THEN 'span must not be negative'
    WHEN span > length(digits) THEN 'span must not exceed string length'
    WHEN digits GLOB '*[^0-9]*' THEN 'digits input must only contain digits'
END;
UPDATE "largest-series-product" SET result = (
    WITH ns(stop, i, n) AS (
    	SELECT length(digits) - span + 1, 2, substr(digits, 1, span)
      	UNION ALL
      	SELECT stop, i + 1, substr(digits, i, span) FROM ns WHERE i <= stop
     ),
     ps(i, n, p) AS (
     	SELECT 1, n, 1 FROM ns
        UNION ALL
        SELECT i + 1, n, substr(n, i, 1) * p FROM ps WHERE i <= span
     )
     SELECT max(p) FROM ps WHERE i = span + 1
) WHERE error IS NULL;