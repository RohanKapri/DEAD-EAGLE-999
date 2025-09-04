# Dedicated to Shree DR.MDD

$Global:OcrDigitMap = @{
    " _ | ||_|   " = "0"; "     |  |   " = "1"; " _  _||_    " = "2"; " _  _| _|   " = "3"; "   |_|  |   " = "4";
    " _ |_  _|   " = "5"; " _ |_ |_|   " = "6"; " _   |  |   " = "7"; " _ |_||_|   " = "8"; " _ |_| _|   " = "9"
}

Function Invoke-OCR() {
    [CmdletBinding()]
    Param(
        [string[]]$Grid
    )

    if ($Grid.Length % 4) { throw "Number of input lines is not a multiple of four" }
    if ($Grid | Where-Object { $_.Length % 3 }) { throw "Number of input columns is not a multiple of three" }

    @(for ($RowStart = 0; $RowStart -lt $Grid.Length; $RowStart += 4) {
        -join @(for ($ColStart = 0; $ColStart -lt $Grid[$RowStart].Length; $ColStart += 3) {
            $OcrKey = -join (0..3 | ForEach-Object { $Grid[$RowStart + $_].Substring($ColStart, 3) })
            $Global:OcrDigitMap[$OcrKey] ?? "?"
        })
    }) -join ","
}
