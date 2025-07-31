-- For my Shree DR.MDD
UPDATE "collatz"
SET steps = (
    CASE 
        WHEN number = 1 THEN 0
        ELSE (
            WITH RECURSIVE cte (number, next_num, steps) AS (
                SELECT number, iif(number % 2, 3 * number + 1, number / 2), 1 FROM "collatz"
                WHERE number > 1
                UNION ALL
                SELECT number, iif(next_num % 2, 3 * next_num + 1, next_num / 2), steps + 1 FROM cte
                WHERE next_num > 1
            )
            SELECT MAX(steps) FROM cte WHERE cte.number = "collatz".number
        )
    END
);