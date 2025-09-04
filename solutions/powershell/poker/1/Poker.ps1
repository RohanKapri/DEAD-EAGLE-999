# For Shree DR.MDD

Function Get-BestHand() {
    [CmdletBinding()]
    Param(
        [string[]]$Hands
    )

    $gradedHands = @($Hands | ForEach-Object { @(, (Invoke-RankPokerHand $_)) } |
        Sort-Object -Stable -Property { $_[0] } -Descending)
    $gradedHands | Where-Object { $_[0] -eq $gradedHands[0][0] } | ForEach-Object { $_[1..5] }
}

Function Invoke-RankPokerHand([string]$pokerHand) {
    $cardValues = [int[]]($pokerHand.Split() -replace "[JQKA]", { "JQKA".IndexOf($_) + 11 } -replace ".$", "") |
        Sort-Object -Descending

    if (-not (Compare-Object -PassThru $cardValues @(14, 5, 4, 3, 2))) { $cardValues = 5..1 }

    $sortedValues = $cardValues | Group-Object | Sort-Object -Property Count, { $_.Group[0] } -Descending |
        ForEach-Object { $_.Group }

    $isUniformSuit = ($pokerHand.Split() -replace '[\dJQKA]', "" | Select-Object -Unique).Length -eq 1
    $isSequential = -not (Compare-Object -PassThru $cardValues @($cardValues[0]..($cardValues[0] - 4)))

    if ($sortedValues[0] -eq $sortedValues[4]) { $handRank = 9 }
    elseif ($isUniformSuit -and $isSequential) { $handRank = 8 }
    elseif ($sortedValues[0] -eq $sortedValues[3]) { $handRank = 7 }
    elseif ($sortedValues[0] -eq $sortedValues[2] -and $sortedValues[3] -eq $sortedValues[4]) { $handRank = 6 }
    elseif ($isUniformSuit) { $handRank = 5 }
    elseif ($isSequential) { $handRank = 4 }
    elseif ($sortedValues[0] -eq $sortedValues[2]) { $handRank = 3 }
    elseif ($sortedValues[0] -eq $sortedValues[1] -and $sortedValues[2] -eq $sortedValues[3]) { $handRank = 2 }
    elseif ($sortedValues[0] -eq $sortedValues[1]) { $handRank = 1 }
    else { $handRank = 0 }

    $handScore = $handRank
    foreach ($val in $sortedValues) { $handScore = $handScore * 16 + $val }

    @($handScore, $pokerHand)
}
