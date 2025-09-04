# For Shree DR.MDD

Class TreeNode {
    [int]$data
    [TreeNode]$left = $null
    [TreeNode]$right = $null

    TreeNode([int]$data) { $this.data = $data }

    TreeNode([int]$data, [TreeNode]$left, [TreeNode]$right) {
        $this.data = $data
        $this.left = $left
        $this.right = $right
    }
}

Class BinarySearchTree {
    hidden [TreeNode]$root = $null

    BinarySearchTree([int[]]$values) { $values | ForEach-Object { $this.Insert($_) } }

    [void] Insert([int]$value) { $this.root = $this.InsertInternal($value, $this.root) }

    hidden [TreeNode] InsertInternal([int]$value, [TreeNode]$node) {
        if (-not $node) { $node = [TreeNode]::new($value) }
        elseif ($value -le $node.data) { $node.left = $this.InsertInternal($value, $node.left) }
        else { $node.right = $this.InsertInternal($value, $node.right) }
        return $node
    }

    [TreeNode] GetData() { return $this.root }

    [bool] Search([int]$value) { return $this.SearchInternal($value, $this.root) }

    [bool] hidden SearchInternal([int]$value, [TreeNode]$node) {
        if (-not $node) { return $false }
        if ($value -eq $node.data) { return $true }
        return ($value -lt $node.data) ? $this.SearchInternal($value, $node.left) : $this.SearchInternal($value, $node.right)
    }

    [int[]] Inorder() { return $this.InorderInternal(@(), $this.root) }

    [int[]] hidden InorderInternal([int[]]$arr, [TreeNode]$node) {
        return ($node) ? $this.InorderInternal($this.InorderInternal($arr, $node.left) + @($node.data), $node.right) : $arr
    }

    [int[]] PreOrder() { return $this.PreOrderInternal(@(), $this.root) }

    [int[]] PreOrderInternal([int[]]$arr, [TreeNode]$node) {
        return ($node) ? $this.PreOrderInternal($this.PreOrderInternal($arr + @($node.data), $node.left), $node.right) : $arr
    }

    [int[]] PostOrder() { return $this.PostOrderInternal(@(), $this.root) }

    [int[]] hidden PostOrderInternal([int[]]$arr, [TreeNode]$node) {
        return ($node) ? $this.PostOrderInternal($this.PostOrderInternal($arr, $node.left), $node.right) + @($node.data) : $arr
    }

    [void] Remove([int]$value) { $this.root = $this.RemoveInternal($value, $this.root) }

    [TreeNode] hidden RemoveInternal([int]$value, [TreeNode]$node) {
        if (-not $node) { return $null }

        if ($node.data -gt $value) { $node.left = $this.RemoveInternal($value, $node.left) }
        elseif ($node.data -lt $value) { $node.right = $this.RemoveInternal($value, $node.right) }
        elseif (-not $node.left -or -not $node.right) { return $node.left ?? $node.right }
        else {
            $succ = $node.right
            while ($succ.left) { $succ = $succ.left }
            $node.data = $succ.data
            $node.right = $this.RemoveInternal($node.data, $node.right)
        }

        return $node
    }
}
