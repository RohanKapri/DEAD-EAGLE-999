UPDATE "rotational-cipher"
SET result = (
    WITH chars(t, c) AS (
        SELECT text, '' UNION ALL
        SELECT
            substr(t, 2),
            IIF(t GLOB '[a-zA-Z]*',
                char((unicode(t) % 32 + shift_key - 1) % 26 + (unicode(t) & 96) + 1),
                substr(t, 1, 1))
        FROM chars
        WHERE t != ''
    )
    SELECT group_concat(c, '') FROM chars
);