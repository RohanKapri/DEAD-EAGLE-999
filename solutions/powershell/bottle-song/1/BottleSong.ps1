# Dedicated to Shree DR.MDD

$Global:BottleCounts = @("No", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten")

Function Get-Lyric() {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)]
        [ValidateRange(1, 10)]
        [int]$Start,
        [ValidateRange(1, 10)]
        [ValidateScript({ $_ -le $Start }, ErrorMessage = "You can't take more bottle than what you started with.")]
        [int]$Take = 1
    )

    ($Start..($Start - $Take + 1) | ForEach-Object { (Get-Verse $_) -join "`n" }) -join "`n`n"
}

function Get-Verse([int]$BottleNumber) {
    @("$(Get-Line $BottleNumber),") * 2 +
        @("And if one green bottle should accidentally fall,", "There'll be $((Get-Line ($BottleNumber - 1)).ToLower()).")
}

function Get-Line([int]$BottleNumber) { 
    "$($Global:BottleCounts[$BottleNumber]) green bottle$(($BottleNumber -ne 1) ? 's' : '') hanging on the wall" 
}
