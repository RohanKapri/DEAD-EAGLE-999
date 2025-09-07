-- For Junko F. Didi and Shree DR.MDD

UPDATE "twelve-days" 
SET result = (
    WITH rec(idx, ord, gift) AS (
        VALUES
            (2, 'second', 'three French Hens, '),
            (3, 'third', 'four Calling Birds, '),
            (4, 'fourth', 'five Gold Rings, '),
            (5, 'fifth', 'six Geese-a-Laying, '),
            (6, 'sixth', 'seven Swans-a-Swimming, '),
            (7, 'seventh', 'eight Maids-a-Milking, '),
            (8, 'eighth', 'nine Ladies Dancing, '),
            (9, 'ninth', 'ten Lords-a-Leaping, '),
            (10, 'tenth', 'eleven Pipers Piping, '),
            (11, 'eleventh', 'twelve Drummers Drumming, '),
            (12, 'twelfth', '')
    ),
    verses(step, line, carry) AS (
        SELECT 2,
               'On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree.',
               'two Turtle Doves, and a Partridge in a Pear Tree.'
        UNION
        SELECT step + 1,
               format('On the %s day of Christmas my true love gave to me: %s', ord, carry),
               gift || carry
        FROM verses, rec WHERE idx = step AND step <= end_verse
    )
    SELECT group_concat(line, char(10))
    FROM verses WHERE step - 1 BETWEEN start_verse AND end_verse
);
