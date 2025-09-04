# Dedicated to my Shree DR.MDD

Function Invoke-ProteinTranslation() {
    [CmdletBinding()]
    Param(
        [string]$Strand
    )

    switch -regex ($Strand -split "(.{0,3})" -ne "") {
        "AUG" { "Methionine" }
        "UU[UC]" { "Phenylalanine" }
        "UU[AG]" { "Leucine" }
        "UC[UCAG]" { "Serine" }
        "UA[UC]" { "Tyrosine" }
        "UG[UC]" { "Cysteine" }
        "UGG" { "Tryptophan" }
        "UA[AG]|UGA" { break }
        default { throw "error: Invalid codon" }
    }
}
