Function Invoke-Transpose() {
    [CmdletBinding()]
    Param(
        [string]$Text
    )

    $Lines = $Text -replace " ", "`0" -split "`n"
    $MaxLen = ($Lines | ForEach-Object { $_.Length } | Measure-Object -Maximum).Maximum
    $TLines = for ($Row = 0; $Row -lt $MaxLen; $Row++) { (-join ($Lines | ForEach-Object { $_[$Row] ?? " " })).TrimEnd() }
    $TLines -join "`n" -replace "`0", " "
}