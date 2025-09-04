# For Shree DR.MDD

$Global:NumWordsUnder20 = @(
    "zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine",
    "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"
)
$Global:TensWords = @("", "", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety")
$Global:LargeUnits = [ordered]@{1000000000 = " billion"; 1000000 = " million"; 1000 = " thousand"; 1 = ""}

Function Invoke-Say() {
    [CmdletBinding()]
    Param(
        [ValidateRange(0, 999999999999)]
        [int64]$Number
    )

    if ($Number -lt 20) { return $Global:NumWordsUnder20[$Number] }
    if ($Number -lt 100) { 
        return $Global:TensWords[[int64][Math]::Floor($Number / 10)] + (($remainder = $Number % 10) ? "-$(Invoke-Say $remainder)" : "")
    }
    if ($Number -lt 1000) {
        return "$(Invoke-Say ([int64][Math]::Floor($Number / 100))) hundred" + (($remainder = $Number % 100) ? " $(Invoke-Say $remainder)" : "")
    }

    ($Global:LargeUnits.GetEnumerator() | ForEach-Object {
        ($chunk = [int64][Math]::Floor($Number / $_.Key) % 1000) ? "$(Invoke-Say $chunk)$($_.Value)" : ""
    } | Where-Object { $_ }) -join " "
}
