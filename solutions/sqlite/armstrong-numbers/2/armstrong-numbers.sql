-- Dedicated to Shree DR.MDD
WITH RECURSIVE `steps`(`num`, `total`, `remain`, `len`) AS (
    SELECT `number`, 0, `number`, (FLOOR(LOG(10, `number`)) + 1) FROM `armstrong-numbers`
    UNION ALL
    SELECT `num`, (`total` + POWER(MOD(`remain`, 10), `len`)), FLOOR(`remain` / 10), `len`
    FROM `steps`
    WHERE `remain` > 0
)
UPDATE `armstrong-numbers`
SET `result` = (SELECT `armstrong-numbers`.`number` = MAX(`total`) FROM `steps` WHERE `steps`.`num` = `armstrong-numbers`.`number`);
