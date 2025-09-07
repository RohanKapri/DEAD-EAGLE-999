---- encoding
UPDATE "run-length-encoding" SET result = (
	WITH blocks(i, b, c1, c) AS (
    	SELECT 2, 0, substr(string, 1, 1), ''
      	UNION
      	SELECT i + 1, b + (c != c1), substr(string, i, 1), c1
      	FROM blocks WHERE c1 != ''
    )
	SELECT group_concat(iif(n > 1, n, '') || c, '')
  	FROM (SELECT c, count(*) n FROM blocks GROUP BY b)
) WHERE property IN ('encode', 'consistency');

-- decoding
UPDATE "run-length-encoding" SET result = (
	WITH blocks(i, c, num) AS (
    	SELECT 2, substr(string, 1, 1), ''
        UNION
        SELECT i + 1, substr(string, i, 1), iif(c GLOB '[0-9]', num || c, '')
    	FROM blocks WHERE c != ''
    ),
	repeat(n, i, num, c, decoded) AS (
    	SELECT n, 1, num, c, c
        FROM (SELECT i n, c, CAST(iif(num != '', num, 1) AS INT) num
              FROM blocks WHERE c != '' AND NOT c GLOB '[0-9]')
        UNION ALL
        SELECT n, i + 1, num, c, decoded || c FROM repeat WHERE i < num
	)
 	SELECT coalesce(group_concat(decoded, ''), '')
  	FROM (SELECT decoded FROM repeat WHERE i = num ORDER BY n)
) WHERE property IN ('decode', 'consistency');