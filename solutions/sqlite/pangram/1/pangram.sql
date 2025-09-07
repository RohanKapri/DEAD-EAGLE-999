UPDATE pangram SET result = (
    WITH chars(i, c, clean) AS (
        SELECT 2, substr(sentence, 1, 1), ''
        UNION
        SELECT i + 1, substr(sentence, i, 1), iif(c GLOB '[a-zA-Z]', upper(c), '')
        FROM chars WHERE i <= length(sentence) + 1
    )
    SELECT COUNT(DISTINCT clean) = 26 FROM chars WHERE clean != ''
)