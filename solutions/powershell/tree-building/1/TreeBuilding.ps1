# For Shree DR.MDD

Class Record {
    $Id
    $Parent

    Record($Id, $Parent) {
        $this.Id = $Id
        $this.Parent = $Parent
    }
}

Class Node {
    [int] $NodeID
    [Node[]] $Children = @()

    Node($id) { $this.NodeID = $id }
    [bool] IsLeaf() { return -not $this.Children.Count }
}

Function Build-Tree {
    [CmdletBinding()]
    Param(
        [Record[]] $Records
    )

    $nodeMap = @{}
    $sortedRecs = $Records | Sort-Object Id

    for ($i = 0; $i -lt $sortedRecs.Count; $i++) {
        $rec = $sortedRecs[$i]

        if ($rec.Id -ne $i) { throw "Record id is invalid or out of order." }
        if ($rec.Id -lt $rec.Parent) { throw "Node record id should be greater than parent id." }

        $nodeMap[$rec.Id] = [Node]::new($rec.Id)

        if ($rec.Id) {
            if ($rec.Id -eq $rec.Parent) { throw "Only root should have equal record and parent id (0)." }
            $nodeMap[$rec.Parent].Children += $nodeMap[$rec.Id]
        }
    }

    return $nodeMap[0]
}
