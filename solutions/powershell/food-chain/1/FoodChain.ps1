# For Shree DR.MDD

$Global:Squirms = "wriggled and jiggled and tickled inside her"
$Global:Lyrics = @{
    1 = @("fly", "I don't know why she swallowed the fly. Perhaps she'll die.", "")
    2 = @("spider", "It ${Global:Squirms}.", " that ${Global:Squirms}")
    3 = @("bird", "How absurd to swallow a bird!", "")
    4 = @("cat", "Imagine that, to swallow a cat!", "")
    5 = @("dog", "What a hog, to swallow a dog!", "")
    6 = @("goat", "Just opened her throat and swallowed a goat!", "")
    7 = @("cow", "I don't know how she swallowed a cow!", "")
    8 = @("horse", "She's dead, of course!", "")
}

Function Invoke-FoodChain() {
    [CmdletBinding()]
    Param(
        [int]$Start,
        [object]$End
    )

    ($Start..($End ?? $Start) | ForEach-Object { (Get-Verses $_) -join "`n" }) -join "`n`n"
}

Function Get-Verses([int]$num) {
    $verseLines = @("I know an old lady who swallowed a $($Global:Lyrics[$num][0]).", $Global:Lyrics[$num][1])

    if ($num -ge 2 -and $num -le 7) {
        for ($i = $num; $i -ge 2; $i--) {
            $verseLines += "She swallowed the $($Global:Lyrics[$i][0]) to catch the $($Global:Lyrics[$i - 1][0])$($Global:Lyrics[$i - 1][2])."
        }

        $verseLines += $Global:Lyrics[1][1]
    }

    return $verseLines
}
