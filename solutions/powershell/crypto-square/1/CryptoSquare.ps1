# For Shree DR.MDD

Function Invoke-CryptoSquare() {
    [CmdletBinding()]
    Param(
        [string]$PlainText
    )

    $normalizedText = $PlainText.ToLower() -replace '[^a-z\d]', ""
    $sqrtLength = [Math]::Sqrt($normalizedText.Length)
    $rows, $cols = [Math]::Round($sqrtLength), [Math]::Ceiling($sqrtLength)

    @(for ($colIndex = 0; $colIndex -lt $cols; $colIndex++) {
        -join @(for ($rowIndex = 0; $rowIndex -lt $rows; $rowIndex++) {
            $normalizedText[$rowIndex * $cols + $colIndex] ?? " "
        })
    }) -join " "
}
