-- For my Shree DR.MDD
WITH count_results AS (
    SELECT
        dice_results,
        category,
        (LENGTH(dice_results) - LENGTH(REPLACE(dice_results, '1', ''))) as count_ones,
        (LENGTH(dice_results) - LENGTH(REPLACE(dice_results, '2', ''))) as count_twos,
        (LENGTH(dice_results) - LENGTH(REPLACE(dice_results, '3', ''))) as count_threes,
        (LENGTH(dice_results) - LENGTH(REPLACE(dice_results, '4', ''))) as count_fours,
        (LENGTH(dice_results) - LENGTH(REPLACE(dice_results, '5', ''))) as count_fives,
        (LENGTH(dice_results) - LENGTH(REPLACE(dice_results, '6', ''))) as count_sixes
    FROM yacht
), aggregated_counts AS (
    SELECT
        dice_results, category, count_ones, count_twos, count_threes, count_fours, count_fives, count_sixes,
        MAX(count_ones, count_twos, count_threes, count_fours, count_fives, count_sixes) as max_count,
        count_ones + 2 * count_twos + 3 * count_threes + 4 * count_fours + 5 * count_fives + 6 * count_sixes as total_score
    FROM count_results
)
UPDATE yacht
SET result = (
    SELECT
        CASE category
        WHEN 'ones' THEN 1 * count_ones
        WHEN 'twos' THEN 2 * count_twos
        WHEN 'threes' THEN 3 * count_threes
        WHEN 'fours' THEN 4 * count_fours
        WHEN 'fives' THEN 5 * count_fives
        WHEN 'sixes' THEN 6 * count_sixes
        WHEN 'full house' THEN IIF(max_count = 3, total_score, 0)
        WHEN 'little straight' THEN IIF(max_count = 1 AND count_sixes = 0, 30, 0)
        WHEN 'big straight' THEN IIF(max_count = 1 AND count_ones = 0, 30, 0)
        WHEN 'yacht' THEN IIF(max_count = 5, 50, 0)
        WHEN 'four of a kind' THEN
            CASE
            WHEN count_ones >= 4 THEN 4
            WHEN count_twos >= 4 THEN 8
            WHEN count_threes >= 4 THEN 12
            WHEN count_fours >= 4 THEN 16
            WHEN count_fives >= 4 THEN 20
            WHEN count_sixes >= 4 THEN 24
            ELSE 0
            END
        WHEN 'choice' THEN total_score
        END
    FROM aggregated_counts
    WHERE yacht.dice_results = aggregated_counts.dice_results AND yacht.category = aggregated_counts.category
);