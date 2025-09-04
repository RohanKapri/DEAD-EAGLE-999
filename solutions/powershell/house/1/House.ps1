# Dedicated to my Shree DR.MDD

$Global:RhymeLines = @(
    "the house that Jack built.",
    "the malt that lay in",
    "the rat that ate",
    "the cat that killed",
    "the dog that worried",
    "the cow with the crumpled horn that tossed",
    "the maiden all forlorn that milked",
    "the man all tattered and torn that kissed",
    "the priest all shaven and shorn that married",
    "the rooster that crowed in the morn that woke",
    "the farmer sowing his corn that kept",
    "the horse and the hound and the horn that belonged to"
)

Function Get-Rhyme() {
    [CmdletBinding()]
    Param(
        [int]$Start,
        [int]$End
    )

    ($Start..$End | ForEach-Object { "This is $($Global:RhymeLines[($_ - 1)..0])" }) -join "`n"
}
