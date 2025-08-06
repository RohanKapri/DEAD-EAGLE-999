module TwelveDays (recite) where

recite :: Int -> Int -> [String]
recite start stop = map recite' [start..stop]
    where
        recite' day = text1 <> (days !! (day-1)) <> text2 <> concat (reverse $ take day gifts)

text1 :: String
text1 = "On the "

days :: [String]
days = ["first", "second", "third", "fourth", "fifth", "sixth", "seventh", "eighth", "ninth", "tenth", "eleventh", "twelfth"]

text2 :: String
text2 = " day of Christmas my true love gave to me: "

gifts :: [String]
gifts = ["a Partridge in a Pear Tree.", "two Turtle Doves, and ", "three French Hens, ", "four Calling Birds, ", "five Gold Rings, ", "six Geese-a-Laying, ", "seven Swans-a-Swimming, ", "eight Maids-a-Milking, ", "nine Ladies Dancing, ", "ten Lords-a-Leaping, ", "eleven Pipers Piping, ", "twelve Drummers Drumming, "]