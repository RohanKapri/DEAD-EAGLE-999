-- Dedicated to Shree DR.MDD
CREATE TABLE IF NOT EXISTS "etl" ("input" TEXT, "result" TEXT);

INSERT INTO etl (input, result) VALUES
    ('{"1":["A"]}', ''),
    ('{"1":["A","E","I","O","U"]}', ''),
    ('{"1":["A","E"],"2":["D","G"]}', ''),
    ('{"1":["A","E","I","O","U","L","N","R","S","T"],"2":["D","G"],"3":["B","C","M","P"],"4":["F","H","V","W","Y"],"5":["K"],"8":["J","X"],"10":["Q","Z"]}', '');

CREATE TABLE IF NOT EXISTS numbers (n INTEGER PRIMARY KEY);

INSERT INTO numbers (n) 
WITH RECURSIVE
  seq(s) AS (SELECT 0 UNION ALL SELECT s+1 FROM seq WHERE s<100)
SELECT s FROM seq;

WITH RECURSIVE
parse_input AS (
    SELECT
        input,
        json_each.key AS pts,
        json_each.value AS chars
    FROM etl, json_each(input)
),
expand_vals AS (
    SELECT
        input,
        LOWER(json_extract(chars, '$[' || n || ']')) AS ch,
        pts
    FROM parse_input
    JOIN numbers ON n < json_array_length(chars)
),
unique_vals AS (
    SELECT DISTINCT
        input,
        ch,
        '"' || ch || '":' || pts AS item
    FROM expand_vals
    WHERE ch IS NOT NULL
),
sort_vals AS (
    SELECT
        input,
        item
    FROM unique_vals
    ORDER BY ch
),
group_vals AS (
    SELECT
        input,
        '{' || GROUP_CONCAT(item, ',') || '}' AS output
    FROM sort_vals
    GROUP BY input
)
UPDATE etl
SET result = (
    SELECT output
    FROM group_vals
    WHERE etl.input = group_vals.input
);
