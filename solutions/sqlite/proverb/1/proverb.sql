UPDATE proverb
SET result = IFNULL(IFNULL((
  SELECT group_concat('For want of a ' || (strings ->> (key - 1)) || ' the ' || value || ' was lost.', char(10))
  FILTER (WHERE key > 0)
  FROM json_each(strings)
) || char(10), '') || 'And all for the want of a ' || (strings ->> 0) || '.', '');