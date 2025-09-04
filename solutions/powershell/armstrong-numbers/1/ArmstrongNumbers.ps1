Function Invoke-ArmstrongNumbers() {
    [CmdletBinding()]
    Param(
        [Int64]$Number
    )

    $Digits = ([string]$Number).ToCharArray() | ForEach-Object { [int][string]$_ }
    ($Digits | ForEach-Object { [Math]::Pow($_, $Digits.Length) } | Measure-Object -sum).sum -eq $Number
}