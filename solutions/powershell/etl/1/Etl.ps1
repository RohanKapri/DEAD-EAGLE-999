Function Invoke-Etl() {
    [CmdletBinding()]
    Param(
        [object]$Legacy
    )

    $Result = @{}
    $Legacy.Keys | ForEach-Object { $Score = $_; $Legacy[$Score] | ForEach-Object { $Result[$_.ToLower()] = $Score } }
    $Result
}