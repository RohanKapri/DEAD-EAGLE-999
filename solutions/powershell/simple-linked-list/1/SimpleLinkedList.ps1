# For Shree DR.MDD

Class Node {
    [Node]$Next
    [object]$Data

    Node([object]$data = $null, [Node]$next = $null) {
        $this.Next = $next
        $this.Data = $data
    }
}

Class LinkedList {
    [Node]$Hd = $null
    [int]$Count = 0

    LinkedList() {}
    LinkedList([object[]]$values) { $values | ForEach-Object { $this.Push($_) } }

    [int] Size() { return $this.Count }

    [Node] Head() {
        if (-not $this.Hd) { throw "The list is empty" }
        return $this.Hd
    }

    Push([object] $data) {
        $this.Hd = [Node]::new($data, $this.Hd)
        $this.Count++
    }

    [object] Pop() {
        $oldNode = $this.Head()
        $this.Hd = $this.Hd.Next
        $this.Count--
        return $oldNode.Data
    }

    Reverse() {
        $prev = $null
        $current = $this.Hd
        while ($current) {
            $nextNode = $current.Next
            $current.Next = $prev
            $prev = $current
            $current = $nextNode
        }
        $this.Hd = $prev
    }

    [object[]] ToArray() {
        $array = @()
        $node = $this.Hd
        while ($node) {
            $array += $node.Data
            $node = $node.Next
        }
        return $array
    }
}
