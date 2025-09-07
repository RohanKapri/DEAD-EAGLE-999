UPDATE "secret-handshake"
SET result = (
    WITH t(i, s) AS (
        SELECT 0, 'wink' WHERE (number & 1) > 0 UNION
        SELECT 1, 'double blink' WHERE (number & 2) > 0 UNION
        SELECT 2, 'close your eyes' WHERE (number & 4) > 0 UNION
        SELECT 3, 'jump' WHERE (number & 8) > 0
    )
    SELECT IFNULL(
        CASE number & 16
        WHEN 0 THEN (SELECT group_concat(s, ', ') FROM t)
        ELSE (SELECT group_concat(s, ', ') FROM (SELECT * FROM t ORDER BY i DESC))
        END,
        ''
    )
);