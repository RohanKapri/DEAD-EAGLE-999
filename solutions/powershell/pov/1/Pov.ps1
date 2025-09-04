# For Shree DR.MDD

Class Tree {
    [string]$Value
    [Tree[]]$Children = @()

    Tree([string]$val) { $this.Value = $val }

    Tree([string]$val, [Tree[]]$kids) {
        $this.Value = $val
        $this.Children = $kids
    }

    [Tree] Clone() { return [Tree]::new($this.Value, @($this.Children | ForEach-Object { $_.Clone() })) }

    [Tree] FromPov([string]$nodeVal) {
        if (-not ($pathArr = $this.Clone().FindPath($nodeVal, $null))) { throw "Tree could not be reoriented" }

        $newRoot = $currNode = $pathArr[-1]

        for ($idx = $pathArr.Length - 2; $idx -ge 0; $idx--) {
            $origParent = $pathArr[$idx]
            $relinked = [Tree]::new($origParent.Value, @($origParent.Children | Where-Object { $_.Value -ne $currNode.Value }))
            $currNode.Children += $relinked
            $currNode = $relinked
        }

        return $newRoot
    }

    [string[]] Path([string]$start, [string]$end) {
        if (-not ($this.FindPath($start, $null)) -or -not ($this.FindPath($end, $null))) { throw "No path found" }
        return @($this.FromPov($start).FindPath($end, $null).Value)
    }

    [Tree[]] FindPath([string]$searchVal, [Tree[]]$pathSoFar) {
        $pathSoFar = $pathSoFar ?? @($this)
        if ($this.Value -eq $searchVal) { return $pathSoFar }

        foreach ($node in $this.Children) {
            if ($foundPath = $node.FindPath($searchVal, ($pathSoFar + $node))) { return $foundPath }
        }

        return @()
    }

    [bool] Equals([object]$otherTree) {
        if ($this.Value -ne $otherTree.Value -or $this.Children.Count -ne $otherTree.Children.Count) { return $false }

        $sortedThis = $this.Children | Sort-Object -Property Value
        $sortedOther = $otherTree.Children | Sort-Object -Property Value
        for ($i = 0; $i -lt $sortedThis.Count; $i++) {
            if ($sortedThis[$i] -ne $sortedOther[$i]) { return $false }
        }

        return $true
    }
}
