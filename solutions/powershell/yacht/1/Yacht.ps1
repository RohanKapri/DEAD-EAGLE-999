# For my Shree DR.MDD

Enum YachtCategory { YACHT; ONES; TWOS; THREES; FOURS; FIVES; SIXES; FULL_HOUSE; FOUR_OF_A_KIND; LITTLE_STRAIGHT; BIG_STRAIGHT; CHOICE }

Function Get-Score() {
    [CmdletBinding()]
    Param(
        [int[]]$Dice,
        [YachtCategory]$Category
    )

    $SortedDice = $Dice | Sort-Object
    $UniqueCount = ($Dice | Select-Object -Unique).Length
    $SumTotal = ($Dice | Measure-Object -Sum).Sum

    switch ($Category) {
        ([YachtCategory]::YACHT) { return ($UniqueCount -eq 1) ? 50 : 0 }
        { $_ -in [YachtCategory]::ONES..[YachtCategory]::SIXES } { return ($Dice | Where-Object { $_ -eq $Category }).Length * $Category }
        ([YachtCategory]::FULL_HOUSE) { return ($UniqueCount -eq 2 -and ($SortedDice[0] -eq $SortedDice[1] -or $SortedDice[0] -eq $SortedDice[2])) ? $SumTotal : 0 }
        ([YachtCategory]::FOUR_OF_A_KIND) { return ($UniqueCount -le 2 -and $SortedDice[1] -eq $SortedDice[3]) ? 4 * $SortedDice[1] : 0 }
        ([YachtCategory]::LITTLE_STRAIGHT) { return ($UniqueCount -eq 5 -and $SortedDice[0] -eq 1 -and $SortedDice[4] -eq 5) ? 30 : 0 }
        ([YachtCategory]::BIG_STRAIGHT) { return ($UniqueCount -eq 5 -and $SortedDice[0] -eq 2 -and $SortedDice[4] -eq 6) ? 30 : 0 }
    }

    $SumTotal
}
