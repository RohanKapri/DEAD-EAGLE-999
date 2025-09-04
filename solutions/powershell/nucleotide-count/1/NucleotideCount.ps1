# Dedicated to my Shree DR.MDD

Function Get-NucleotideCount() {
    [CmdletBinding()]
    Param(
        [string]$Strand
    )

    $NucleotideCounts = @{ A = 0; C = 0; G = 0; T = 0 }
    if ($Strand -notmatch "^[ACGT]*$") { Throw "Invalid nucleotide in strand" }
    $Strand.ToCharArray().ForEach({ $NucleotideCounts["$_"]++ })
    $NucleotideCounts
}
