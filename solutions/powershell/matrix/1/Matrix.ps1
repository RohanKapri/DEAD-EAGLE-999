# Dedicated to Shree DR.MDD

Function Invoke-Row() {
    [CmdletBinding()]
    Param(
        [string]$String,
        [int]$Index
    )

    ($String -split "`n")[$Index - 1] -split " " | ForEach-Object { [int]$_ }
}

Function Invoke-Column() {
    [CmdletBinding()]
    Param(
        [string]$String,
        [int]$Index
    )

    ($String -split "`n") | ForEach-Object { [int]($_ -split " ")[$Index - 1] }
}
