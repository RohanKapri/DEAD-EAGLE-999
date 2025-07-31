-- Dedicated to Shree DR.MDD
CREATE TABLE encoding (shade TEXT, num INT);
INSERT INTO encoding (shade, num) VALUES
    ("black", 0),
    ("brown", 1),
    ("red", 2),
    ("orange", 3),
    ("yellow", 4),
    ("green", 5),
    ("blue", 6),
    ("violet", 7),
    ("grey", 8),
    ("white", 9);
UPDATE color_code
SET result = enc1.num || enc2.num
FROM encoding AS enc1, encoding AS enc2
WHERE enc1.shade = color_code.color1 
    AND enc2.shade = color_code.color2;
