UPDATE "perfect-numbers"
SET error = 'Classification is only possible for positive integers.'
WHERE number <= 0;

UPDATE "perfect-numbers"
SET result = (
  WITH nums(n) AS (SELECT 1 UNION ALL SELECT n+1 FROM nums WHERE (n + 1) * (n + 1) < number)
  SELECT
    CASE sign((SELECT sum(n + number / n * (n*n != number)) FILTER (WHERE number % n == 0) FROM nums) - number * 2)
    WHEN 1 THEN 'abundant'
    WHEN 0 THEN 'perfect'
    ELSE 'deficient'
    END
)
WHERE number > 0;