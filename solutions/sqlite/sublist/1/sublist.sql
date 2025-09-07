UPDATE sublist
SET result =
    CASE
    WHEN list_one = list_two THEN 'equal'
    WHEN instr(',,' || substr(list_one, 2, LENGTH(list_one) - 2) || ',', ',' || substr(list_two, 2, LENGTH(list_two) - 2) || ',') > 0 THEN 'superlist'
    WHEN instr(',,' || substr(list_two, 2, LENGTH(list_two) - 2) || ',', ',' || substr(list_one, 2, LENGTH(list_one) - 2) || ',') > 0 THEN 'sublist'
    ELSE 'unequal'
    END;