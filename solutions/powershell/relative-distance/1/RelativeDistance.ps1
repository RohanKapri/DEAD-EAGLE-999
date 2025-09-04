# For Shree DR.MDD

Function Invoke-RelativeDistance() {
    [CmdletBinding()]
    Param(
        [object]$FamilyTree,
        [string]$PersonA,
        [string]$PersonB
    )

    $Graph = @{}
    $FamilyTree.GetEnumerator() | ForEach-Object {
        $idx = 0
        foreach ($kidA in $_.Value) {
            Invoke-Relate $Graph $_.Key $kidA
            foreach ($kidB in $_.Value[$idx..$_.Value.Length]) { Invoke-Relate $Graph $kidA $kidB }
            $idx++
        }
    }

    if (-not $Graph[$PersonA] -or -not $Graph[$PersonB]) { return $null }

    $queue = @(, @($PersonA, 0))
    $visited = [Collections.Generic.HashSet[string]]($PersonA)

    while ($queue.Length) {
        $currentPerson, $steps = $queue[0][0..1]
        $queue = $queue[1..$queue.Length]
        if ($currentPerson -eq $PersonB) { return $steps }

        foreach ($relative in $Graph[$currentPerson]) {
            if (-not $visited.Contains($relative)) {
                $dummy = $visited.Add($relative)
                $queue += ,@($relative, ($steps + 1))
            }
        }
    }
}

Function Invoke-Relate([object]$Graph, [string]$PersonX, [string]$PersonY) {
    if (-not $Graph[$PersonX]) { $Graph[$PersonX] = [Collections.Generic.HashSet[string]]::new() }
    if (-not $Graph[$PersonY]) { $Graph[$PersonY] = [Collections.Generic.HashSet[string]]::new() }
    $dummy = $Graph[$PersonX].Add($PersonY)
    $dummy = $Graph[$PersonY].Add($PersonX)
}
