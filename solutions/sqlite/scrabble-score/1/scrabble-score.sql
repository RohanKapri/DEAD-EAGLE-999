UPDATE "scrabble-score"
SET result = (
    WITH RECURSIVE letters(i, v) AS (
        VALUES(1, 0)
        UNION ALL
        SELECT i+1, unicode(substr("1332142418513113:11114484:", unicode(upper(substr(word, i, 1))) - 64, 1)) - 48
        FROM letters
        WHERE i <= length(word)
    )
    SELECT sum(v)
    FROM letters
);