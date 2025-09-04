Function Invoke-Diamond() {
    [CmdletBinding()]
    Param(
        [char]$Letter
    )

    $ULetter = [char](([string]$Letter).ToUpper())
    if ($ULetter -eq "A") { return "A`n" }
    ("A"..$ULetter + [char]($ULetter - 1).."A" | ForEach-Object { $X = $_;
        -join ($ULetter.."A" + "B"..$ULetter | ForEach-Object { $_ -eq $X ? $_ : " " }) }) -join "`r`n"
}