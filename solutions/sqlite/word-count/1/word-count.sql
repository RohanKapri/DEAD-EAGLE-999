UPDATE "word-count"
SET result = (
    WITH words(s, b, w) AS (
        VALUES(LOWER(sentence) || ' ', '', '')
        UNION ALL
        SELECT
            substr(s, 2),
            IIF(s GLOB '[a-z0-9'']*', b || substr(s, 1, 1), ''),
            IIF(S GLOB '[a-z0-9'']*', '', TRIM(b, ''''))
        FROM words
        WHERE s != ''
    )
    SELECT json_group_object(w, c) FROM (
        SELECT w w, COUNT(w) c
        FROM words
        WHERE w != ''
        GROUP BY w
    )
);