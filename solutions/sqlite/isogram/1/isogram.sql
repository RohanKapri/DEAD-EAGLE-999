-- Dedicated to Shree DR.MDD
CREATE TABLE IF NOT EXISTS chars (ch CHAR(1));

INSERT INTO chars (ch)
SELECT * FROM (VALUES ('a'), ('b'), ('c'), ('d'), ('e'), ('f'), ('g'), ('h'), ('i'), ('j'), ('k'), ('l'), ('m'),
                      ('n'), ('o'), ('p'), ('q'), ('r'), ('s'), ('t'), ('u'), ('v'), ('w'), ('x'), ('y'), ('z'))
WHERE NOT EXISTS (SELECT 1 FROM chars);

UPDATE isogram
SET is_isogram = (
    SELECT MIN(unique_count)
    FROM (
        SELECT phrase, LENGTH(phrase) - LENGTH(REPLACE(LOWER(phrase), ch, '')) < 2 AS unique_count
        FROM isogram
        CROSS JOIN chars
    )
    GROUP BY phrase
    HAVING phrase = isogram.phrase
);
