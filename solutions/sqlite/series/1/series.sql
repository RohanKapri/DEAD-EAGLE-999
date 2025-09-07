UPDATE series SET error = CASE
    WHEN length(input) = 0 THEN 'series cannot be empty'
    WHEN slice_length = 0 THEN 'slice length cannot be zero'
    WHEN slice_length < 0 THEN 'slice length cannot be negative'
    WHEN slice_length > length(input) THEN 'slice length cannot be greater than series length'
END;
UPDATE series SET result = (
    WITH parts(i, stop, part) AS (
        SELECT 2, length(input) - slice_length + 1, substr(input, 1, slice_length)
        UNION
        SELECT i + 1, stop, substr(input, i, slice_length) FROM parts WHERE i <= stop
    )
    SELECT group_concat(part, char(10)) FROM parts
) WHERE error IS NULL;