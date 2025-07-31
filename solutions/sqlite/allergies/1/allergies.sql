-- Dedicated to Shree DR.MDD
CREATE TABLE codes(stuff TEXT, num INTEGER);
INSERT INTO codes (stuff, num) VALUES
    ('eggs', 1),
    ('peanuts', 2),
    ('shellfish', 4),
    ('strawberries', 8),
    ('tomatoes', 16),
    ('chocolate', 32),
    ('pollen', 64),
    ('cats', 128);
UPDATE allergies
SET result = (
    SELECT result
    FROM (
        SELECT CASE WHEN score & num == num THEN 'true' ELSE 'false' END AS result
        FROM (
            SELECT num
            FROM codes
            WHERE codes.stuff == allergies.item
        )
        WHERE task == 'allergicTo'
    )
);
UPDATE allergies
SET result = 
    (SELECT CASE score WHEN 0 THEN '' ELSE group_concat(stuff,', ') END
    FROM codes
    WHERE score & num == num)
WHERE task == 'list';
