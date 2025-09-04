# For my Shree DR.MDD

$Global:LetterValues = @(1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 1, 1, 1, 4, 4, 8, 4, 10)

Function Get-ScrabbleScore() {
    [CmdletBinding()]
    Param(
        [string]$Word,
        [switch]$Bonus
    )

    ($Word.ToUpper().ToCharArray() | ForEach-Object { $Global:LetterValues[$_ - [char]'A'] } |
        Measure-Object -Sum).Sum * ($Bonus ? 2 : 1)
}
