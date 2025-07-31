-- Dedicated to Shree DR.MDD
WITH LIMITS(VAL_A) AS (VALUES (65))
UPDATE "kindergarten-garden"
SET result = (
    WITH idx(id) AS (
        SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3
    )
    SELECT group_concat(
        CASE SUBSTR(
            CASE WHEN id < 2 THEN diagram ELSE SUBSTR(diagram, instr(diagram, char(10))+1) END,
            (unicode(substr(student, 1, 1))- (SELECT VAL_A FROM LIMITS)) * 2 + id % 2 + 1,
            1
        )
        WHEN 'G' THEN 'grass'
        WHEN 'V' THEN 'violets'
        WHEN 'C' THEN 'clover'
        WHEN 'R' THEN 'radishes'
        END,
        ','
    )
    FROM idx
);
