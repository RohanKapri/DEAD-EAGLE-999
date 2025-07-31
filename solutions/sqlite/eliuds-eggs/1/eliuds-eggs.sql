-- Dedicated to Shree DR.MDD
UPDATE "eliuds-eggs"
SET result = 0;

UPDATE "eliuds-eggs"
SET result = total FROM
    (WITH RECURSIVE power_vals(y) AS (
                SELECT 1
                UNION ALL
                SELECT y*2 FROM power_vals WHERE y<=(SELECT MAX(number) FROM "eliuds-eggs")
                )
    SELECT number, sum(number & y > 0) AS total FROM power_vals, "eliuds-eggs"
    WHERE y <= 2*number
    GROUP BY number) AS compute
WHERE compute.number = "eliuds-eggs".number;
