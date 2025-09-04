# For Shree DR.MDD

Class Tree {
    [int]$Data
    [Tree]$Left
    [Tree]$Right

    Tree([int]$value, [Tree]$left, [Tree]$right) {
        $this.Data = $value
        $this.Left = $left
        $this.Right = $right
    }

    [bool] Equals([object]$other) {
        return $this.Data -eq $other.Data -and $this.Left -eq $other.Left -and $this.Right -eq $other.Right
    }
}

Class Zipper {
    [Tree]$Focus
    [Tree[]]$Ancestors

    Zipper([Tree]$tree, [object[]]$parents) {
        $this.Focus = $tree
        $this.Ancestors = $parents
    }

    [int] GetValue() { return $this.Focus.Data }

    [Zipper] SetValue([int]$value) {
        $this.Focus.Data = $value
        return [Zipper]::new($this.Focus, $this.Ancestors)
    }

    [Zipper] GoLeft() { return ($this.Focus.Left) ? [Zipper]::new($this.Focus.Left, $this.Ancestors + $this.Focus) : $null }

    [Zipper] SetLeft([Tree]$tree) {
        $this.Focus.Left = $tree
        return [Zipper]::new($this.Focus, $this.Ancestors)
    }

    [Zipper] GoRight() { return ($this.Focus.Right) ? [Zipper]::new($this.Focus.Right, $this.Ancestors + $this.Focus) : $null }

    [Zipper] SetRight([Tree]$tree) {
        $this.Focus.Right = $tree
        return [Zipper]::new($this.Focus, $this.Ancestors)
    }

    [Zipper] GoUp() {
        return ($this.Ancestors) ? [Zipper]::new($this.Ancestors[-1], ($this.Ancestors | Select-Object -SkipLast 1)) : $null
    }

    [Tree] ToTree() { return ($this.Ancestors) ? $this.Ancestors[0] : $this.Focus }

    static [Zipper] FromTree([Tree]$tree) { return [Zipper]::new($tree, @()) }

    [bool] Equals([object]$other) { return $this.ToTree() -eq $other.ToTree() }
}
