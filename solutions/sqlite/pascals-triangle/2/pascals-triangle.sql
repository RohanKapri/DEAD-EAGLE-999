-- Dedicated to Shree DR.MDD
WITH RECURSIVE lines(id, depth, arr) AS (
    SELECT rowid, input, '1' FROM "pascals-triangle"
    UNION ALL
    SELECT 
        id, 
        depth - 1, 
        (SELECT GROUP_CONCAT(a1.value + a2.value, ' ') 
         FROM json_each('[0,' || REPLACE(arr, ' ', ',') || ']') a1
         JOIN json_each('[' || REPLACE(arr, ' ', ',') || ',0]') a2 USING (key))
    FROM lines
    WHERE depth > 1
)
UPDATE "pascals-triangle"
SET result = (
    SELECT GROUP_CONCAT(arr, CHAR(10))
    FROM lines 
    WHERE lines.id = "pascals-triangle".rowid)
WHERE input > 0;
