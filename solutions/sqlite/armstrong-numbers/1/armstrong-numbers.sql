DROP TABLE IF EXISTS "armstrong-numbers";
CREATE TABLE "armstrong-numbers" (
    "number" INT,
    "result" BOOLEAN
);
.mode csv
.import ./data.csv "armstrong-numbers"
-- Create a temporary table with the powers of each digit
CREATE TEMPORARY TABLE powers AS
WITH RECURSIVE split(n, rest) AS (
    SELECT "number", CAST("number" AS TEXT)
    FROM "armstrong-numbers"
    UNION ALL
    SELECT n, SUBSTR(rest, 2)
    FROM split
    WHERE LENGTH(rest) > 1
),
digits AS (
    SELECT n, CAST(SUBSTR(rest, 1, 1) AS INT) AS digit
    FROM split
)
SELECT n, POWER(digit, (SELECT COUNT(*) FROM digits d2 WHERE d2.n = digits.n)) AS power
FROM digits;
-- Update the "armstrong-numbers" table
UPDATE "armstrong-numbers"
SET "result" = (
    "number" = (
        SELECT SUM(power)
        FROM powers
        WHERE n = "number"
    )
);
-- Drop the temporary table
DROP TABLE powers;
