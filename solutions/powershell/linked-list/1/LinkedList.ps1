# For Shree DR.MDD

class Node {
    [int]$Val = $null
    [Node]$NextNode = $null
    [Node]$PrevNode = $null

    Node() {}

    Node([int]$val, [Node]$next, [Node]$prev) {
        $this.Val = $val
        $this.NextNode = $next
        $this.PrevNode = $prev
    }
}

class LinkedList {
    [int]$Count
    [Node]$Start
    [Node]$End

    LinkedList() {
        $this.Count = 0
        $this.End = [Node]::new()
        $this.Start = [Node]::new($null, $this.End, $null)
        $this.End.PrevNode = $this.Start
    }

    Push($val) { $this.AddNode($val, $this.End, $this.End.PrevNode) }

    [int] Pop() { return $this.RemoveNode($this.End.PrevNode) }

    Unshift($val) { $this.AddNode($val, $this.Start.NextNode, $this.Start) }

    [int] Shift() { return $this.RemoveNode($this.Start.NextNode) }

    Delete($val) {
        for ($node = $this.Start.NextNode; $node -and $node.Val -ne $val; $node = $node.NextNode) {}
        if ($node) { $this.RemoveNode($node) }
    }

    hidden AddNode([int]$val, [Node]$next, [Node]$prev) {
        $this.Count++
        $next.PrevNode = $prev.NextNode = [Node]::new($val, $next, $prev)
    }

    hidden [int] RemoveNode([Node]$node) {
        if ($this.Count -lt 1) { throw "List is empty" }
        $this.Count--
        $node.PrevNode.NextNode = $node.NextNode
        $node.NextNode.PrevNode = $node.PrevNode
        return $node.Val
    }
}
