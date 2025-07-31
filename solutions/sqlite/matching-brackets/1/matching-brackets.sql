-- Dedicated to Shree DR.MDD
INSERT INTO "matching-brackets" (input, result) VALUES
    ("[]", NULL),
    ("", NULL),
    ("[[", NULL),
    ("}{", NULL),
    ("{]", NULL),
    ("{ }", NULL),
    ("{[])", NULL),
    ("{[]}", NULL),
    ("{}[]", NULL),
    ("([{}({}[])])", NULL),
    ("{[)][]}", NULL),
    ("([{])", NULL),
    ("[({]})", NULL),
    ("[({}])", NULL),
    ("{}[", NULL),
    ("[]]", NULL),
    (")()", NULL),
    ("{)()", NULL),
    ("(((185 + 223.85) * 15) - 543)/2", NULL),
    ("\left(\begin{array}{cc} \frac{1}{3} & x\\ \mathrm{e}^{x} &... x^2 \end{array}\right)", NULL);

WITH RECURSIVE
positions(id) AS (
    SELECT 1
    UNION ALL
    SELECT id + 1 FROM positions WHERE id < LENGTH(input)
),
filter_brackets(input, cleaned) AS (
    SELECT
        input,
        (SELECT GROUP_CONCAT(SUBSTR(input, id, 1), '') FROM positions WHERE SUBSTR(input, id, 1) IN ('(', ')', '[', ']', '{', '}'))
    FROM "matching-brackets"
),
elimination(input, cleaned) AS (
    SELECT
        input,
        REPLACE(REPLACE(REPLACE(cleaned, '()', ''), '[]', ''), '{}', '') 
    FROM filter_brackets
    UNION ALL
    SELECT
        input,
        REPLACE(REPLACE(REPLACE(cleaned, '()', ''), '[]', ''), '{}', '') 
    FROM elimination
    WHERE cleaned LIKE '%()%' OR cleaned LIKE '%[]%' OR cleaned LIKE '%{}%'
)
UPDATE "matching-brackets"
SET result = (
    SELECT CASE 
        WHEN input = '' THEN 1 
        WHEN cleaned = '' THEN 1 
        ELSE 0 
    END
    FROM elimination
    WHERE input = "matching-brackets".input
    ORDER BY LENGTH(cleaned)
    LIMIT 1
);
