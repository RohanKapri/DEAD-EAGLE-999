ALTER TABLE "isbn-verifier"
ADD clean TEXT DEFAULT '';
UPDATE "isbn-verifier"
SET clean = REPLACE(isbn, "-", "");
UPDATE "isbn-verifier"
SET result = (
    clean REGEXP "^[0-9]{9}[0-9X]$" AND
    (SUBSTR(clean, 1, 1) * 10 +
    SUBSTR(clean, 2, 1) * 9 +
    SUBSTR(clean, 3, 1) * 8 +
    SUBSTR(clean, 4, 1) * 7 +
    SUBSTR(clean, 5, 1) * 6 +
    SUBSTR(clean, 6, 1) * 5 +
    SUBSTR(clean, 7, 1) * 4 +
    SUBSTR(clean, 8, 1) * 3 +
    SUBSTR(clean, 9, 1) * 2 +
    REPLACE(SUBSTR(clean, 10, 1), "X", "10") * 1) % 11 = 0
);
