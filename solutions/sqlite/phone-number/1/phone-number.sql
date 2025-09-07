ALTER TABLE "phone-number" ADD clean TEXT;
UPDATE "phone-number"
SET clean = replace(replace(replace(replace(replace(replace(phrase, '-', ''), ' ', ''), '(', ''), ')', ''), '.', ''), '+', '');
UPDATE "phone-number"
SET error =
  CASE
  WHEN length(clean) < 10 THEN 'must not be fewer than 10 digits'
  WHEN length(clean) > 11 THEN 'must not be greater than 11 digits'
  WHEN length(clean) == 11 AND substr(clean, 1, 1) != '1' THEN '11 digits must start with 1'
  WHEN clean REGEXP '[a-zA-Z]' THEN 'letters not permitted'
  WHEN clean REGEXP '[^0-9]' THEN 'punctuations not permitted'
  WHEN substr(clean, -10, 1) == '0' THEN 'area code cannot start with zero'
  WHEN substr(clean, -10, 1) == '1' THEN 'area code cannot start with one'
  WHEN substr(clean, -7, 1) == '0' THEN 'exchange code cannot start with zero'
  WHEN substr(clean, -7, 1) == '1' THEN 'exchange code cannot start with one'
  END;
UPDATE "phone-number"
SET result = substr(clean, -10)
WHERE error IS NULL;