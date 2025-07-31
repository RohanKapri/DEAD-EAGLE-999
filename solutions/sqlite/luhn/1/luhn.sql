-- Dedicated to Shree DR.MDD
PRAGMA recursive_triggers = ON;

WITH RECURSIVE number_sequence(id) AS (
    SELECT 1
    UNION ALL
    SELECT id+1 FROM number_sequence LIMIT (SELECT MAX(LENGTH(REPLACE(value, ' ', ''))) FROM luhn)
),
luhn_data AS (
    SELECT value, REPLACE(value, ' ', '') AS pure_val FROM luhn
)
UPDATE luhn
SET result = 0
WHERE value GLOB '*[^0-9 ]*' OR REPLACE(value, ' ', '') = '0';

WITH RECURSIVE number_sequence(id) AS (
    SELECT 1
    UNION ALL
    SELECT id + 1 FROM number_sequence LIMIT (SELECT MAX(LENGTH(REPLACE(value, ' ', ''))) FROM luhn)
),
luhn_data AS (
    SELECT value, REPLACE(value, ' ', '') AS pure_val FROM luhn
    WHERE value NOT GLOB '*[^0-9 ]*' AND REPLACE(value, ' ', '') != '0'
),
calculations AS (
    SELECT ld.value,
           SUM(
               CASE
                   WHEN (LENGTH(pure_val) - id + 1) % 2 = 0 THEN 
                       CASE
                           WHEN CAST(SUBSTR(pure_val, id, 1) AS INTEGER) * 2 > 9 THEN
                                CAST(SUBSTR(pure_val, id, 1) AS INTEGER) * 2 - 9
                           ELSE
                                CAST(SUBSTR(pure_val, id, 1) AS INTEGER) * 2
                       END
                   ELSE 
                       CAST(SUBSTR(pure_val, id, 1) AS INTEGER)
               END
           ) AS checksum
    FROM luhn_data ld, number_sequence
    WHERE number_sequence.id <= LENGTH(pure_val)
    GROUP BY ld.value
)
UPDATE luhn
SET result = CASE
                 WHEN (SELECT checksum FROM calculations WHERE calculations.value = luhn.value) % 10 = 0 THEN 1
                 ELSE 0
             END
WHERE NOT value GLOB '*[^0-9 ]*' AND REPLACE(value, ' ', '') != '0' AND EXISTS (SELECT 1 FROM calculations WHERE calculations.value = luhn.value);
