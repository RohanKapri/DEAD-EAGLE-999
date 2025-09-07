UPDATE "ocr-numbers" SET (error, result) = (
    WITH map(pattern, digit) AS (
        VALUES (' _ | ||_|', 0), ('     |  |', 1), (' _  _||_ ', 2),
               (' _  _| _|', 3), ('   |_|  |', 4), (' _ |_  _|', 5),
               (' _ |_ |_|', 6), (' _   |  |', 7), (' _ |_||_|', 8),
               (' _ |_| _|', 9)
    ),
	cs(i, r, c) AS (
    	SELECT 1, 0, char(10)
      	UNION ALL
      	SELECT i + 1, r + (c = char(10)), substr(input, i, 1)
        FROM cs WHERE c != ''
    ),
  	ls(r, line) AS (
    	SELECT r, group_concat(c, '') FROM cs WHERE c != char(10) GROUP BY r
    ),
  	errors(error) AS (
      	SELECT CASE
      	    WHEN max(r) % 4 THEN
                'Number of input lines is not a multiple of four'
      	    WHEN sum(length(line) % 3) THEN 
                'Number of input columns is not a multiple of three'
      	END FROM ls
    ),
  	ps(r, line, i, len, part) AS (
    	SELECT r, line, 4, length(line), substr(line, 1, 3) FROM ls WHERE r % 4
      	UNION ALL
      	SELECT r, line, i + 3, len, substr(line, i, 3) FROM ps WHERE i < len
	),
  	pats(n, p) AS (
    	SELECT r / 4 + 1 n, group_concat(part, '') FROM ps GROUP BY n, i
    )
  	SELECT error, iif(error IS NULL, group_concat(n, ','), NULL)
  	FROM (SELECT group_concat(ifnull(digit, '?'), '') n
  		  FROM pats LEFT JOIN map ON p = pattern GROUP BY n), errors
)