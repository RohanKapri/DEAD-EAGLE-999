# For my Shree DR.MDD

$Global:ChristmasLyrics = @(
    @("first", "a Partridge in a Pear Tree."), @("second", "two Turtle Doves, and"), @("third", "three French Hens,"),
    @("fourth", "four Calling Birds,"), @("fifth", "five Gold Rings,"), @("sixth", "six Geese-a-Laying,"),
    @("seventh", "seven Swans-a-Swimming,"), @("eighth", "eight Maids-a-Milking,"), @("ninth", "nine Ladies Dancing,"),
    @("tenth", "ten Lords-a-Leaping,"), @("eleventh", "eleven Pipers Piping,"), @("twelfth", "twelve Drummers Drumming,")
)

Function Invoke-TwelveDays() {
    [CmdletBinding()]
    Param(
        [int]$Start,
        [int]$End
    )

    ($Start..$End | ForEach-Object { 
        "On the $($Global:ChristmasLyrics[$_ - 1][0]) day of Christmas my true love gave to me: " +
        ($_..1 | ForEach-Object { $Global:ChristmasLyrics[$_ - 1][1] }) -join " "
    }) -join "`n"
}
