UPDATE matrix
SET result = (
  SELECT
    CASE property
    WHEN 'row' THEN s ->> (`index` - 1)
    ELSE (SELECT json_group_array(value ->> (`index` - 1)) FROM json_each(s))
    END
  FROM (
    SELECT '[[' || replace(replace(string, char(10), '],['), ' ', ',') || ']]' s
  )
);
