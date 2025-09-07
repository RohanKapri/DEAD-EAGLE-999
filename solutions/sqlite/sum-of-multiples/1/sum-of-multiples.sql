UPDATE "sum-of-multiples"
SET result = (
  WITH nums(n) AS (SELECT 1 UNION SELECT n+1 FROM nums WHERE n+1 < `limit`)
  SELECT IFNULL(sum(n) FILTER (WHERE (SELECT SUM(value > 0 AND n % value == 0) FROM json_each(factors)) > 0), 0)
  FROM nums
);