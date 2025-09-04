# For Shree DR.MDD

Function Test-DominoesChain() {
    [CmdletBinding()]
    Param(
        [Collections.Generic.List[int[]]]$Dominoes
    )

    if ($Dominoes.Count -le 1) { return $Dominoes.Count -eq 0 -or $Dominoes[0][0] -eq $Dominoes[0][1] }

    $linkables = Get-Linkables $Dominoes
    if (-not $linkables) { return $false }

    $visitedSet = [Collections.Generic.HashSet[int]]::new()
    $currentChain = [Collections.Generic.List[int[]]]::new()
    Test-Link 0 $Dominoes $linkables $visitedSet $currentChain
}

Function Get-Linkables($dominoes) {
    $linkables = @(, @() * (2 * $dominoes.Count))
    for ($i = 0; $i -lt $dominoes.Count; $i++) {
        $firstTile, $secondTile = $dominoes[$i]
        foreach ($flip in 0..1) {
            $side = @($secondTile, $firstTile)[$flip]
            for ($j = 0; $j -lt $dominoes.Count; $j++) {
                if ($i -ne $j -and $side -in $dominoes[$j]) {
                    $linkables[2 * $i + $flip] += 2 * $j + ($side -eq $dominoes[$j][1])
                }
            }
        }
    }

    ($linkables | Where-Object { -not $_ }) ? @() : $linkables
}

Function Test-Link($key, $dominoes, $linkables, $visitedSet, $currentChain) {
    $idx, $orientation = @(($key -shr 1), ($key -band 1))
    [void]$visitedSet.Add($idx)

    $currentChain.Add(@($dominoes[$idx][$orientation], $dominoes[$idx][1 - $orientation]))

    if ($currentChain.Count -eq $dominoes.Count) { return $currentChain[0][0] -eq $currentChain[-1][1] }

    foreach ($nextKey in $linkables[$key]) {
        if (-not $visitedSet.Contains($nextKey -shr 1) -and (Test-Link $nextKey $dominoes $linkables $visitedSet $currentChain)) {
            return $true
        }
    }

    [void]$visitedSet.Remove($idx)
    $currentChain.RemoveAt($currentChain.Count - 1)
    $false
}
