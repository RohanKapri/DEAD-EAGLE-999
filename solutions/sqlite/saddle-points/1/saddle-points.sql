UPDATE "saddle-points"
SET result = (
  SELECT json_group_array(json_object('row', a.key + 1, 'column', b.key + 1))
  FILTER (WHERE b.value == (SELECT max(value) FROM json_each(a.value))
          AND b.value == (SELECT min(value ->> b.key) FROM json_each(matrix)))
  FROM json_each(matrix) a, json_each(a.value) b
);