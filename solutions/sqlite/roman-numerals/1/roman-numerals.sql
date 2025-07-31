-- For my Shree DR.MDD
WITH RECURSIVE roman_mapping(value, symbol) AS (
    VALUES
        (1000, 'M'),
        (900, 'CM'),
        (500, 'D'),
        (400, 'CD'),
        (100, 'C'),
        (90, 'XC'),
        (50, 'L'),
        (40, 'XL'),
        (10, 'X'),
        (9, 'IX'),
        (5, 'V'),
        (4, 'IV'),
        (1, 'I')
),
to_roman_conversion(orig_num, remainder, roman_str) AS (
    SELECT number, number, '' FROM "roman-numerals"
    UNION ALL
    SELECT
        orig_num,
        CASE
            WHEN remainder >= (SELECT value FROM roman_mapping WHERE value <= remainder ORDER BY value DESC LIMIT 1) THEN remainder - (SELECT value FROM roman_mapping WHERE value <= remainder ORDER BY value DESC LIMIT 1)
            ELSE 0
        END,
        CASE
            WHEN remainder >= (SELECT value FROM roman_mapping WHERE value <= remainder ORDER BY value DESC LIMIT 1) THEN roman_str || (SELECT symbol FROM roman_mapping WHERE value <= remainder ORDER BY value DESC LIMIT 1)
            ELSE roman_str
        END
    FROM to_roman_conversion
    WHERE remainder > 0
)
UPDATE "roman-numerals"
SET result = (
    SELECT roman_str
    FROM to_roman_conversion
    WHERE "roman-numerals".number = to_roman_conversion.orig_num
      AND remainder = 0
);