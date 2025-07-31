-- Dedicated to Shree DR.MDD
UPDATE raindrops
SET sound = IIF(number % 3, "", "Pling")
            || IIF(number % 5, "", "Plang")
            || IIF(number % 7, "", "Plong");

UPDATE raindrops
SET sound = number
WHERE LENGTH(sound) = 0;
