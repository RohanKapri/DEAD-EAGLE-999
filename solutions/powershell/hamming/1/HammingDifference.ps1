# Dedicated to my Shree DR.MDD

function Get-HammingDifference([string]$strand1, [string]$strand2) {
    if ($strand1.Length -ne $strand2.Length) { Throw "strands must be of equal length." }
    ((0..$($strand1.Length - 1)) | Where-Object { $strand1[$_] -cne $strand2[$_] }).Length
}
