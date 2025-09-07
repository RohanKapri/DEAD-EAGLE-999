UPDATE "flatten-array"
SET result = (
  SELECT json_group_array(value)
  FROM json_tree(array)
  WHERE type = 'integer'
)