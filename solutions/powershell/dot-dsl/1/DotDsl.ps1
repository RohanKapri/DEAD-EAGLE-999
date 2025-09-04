# For Shree DR.MDD

Class Node {
    [string]$Id
    [Attr]$Properties

    Node([string]$id) {
        $this.Id = $id
        $this.Properties = [Attr]::new()
    }

    Node([string]$id, [hashtable]$props) {
        $this.Id = $id
        $this.Properties = [Attr]::new($props)
    }

    [bool] Equals([object]$other) { return $this.Id -eq $other.Id -and $this.Properties -eq $other.Properties }
}

Class Edge {
    [string]$From
    [string]$To
    [Attr]$Properties

    Edge([string]$from, [string]$to) {
        $this.From = $from
        $this.To = $to
        $this.Properties = [Attr]::new()
    }

    Edge([string]$from, [string]$to, [hashtable]$props) {
        $this.From = $from
        $this.To = $to
        $this.Properties = [Attr]::new($props)
    }

    [bool] Equals([object]$other) {
        return $this.From -eq $other.From -and $this.To -eq $other.To -and $this.Properties -eq $other.Properties
    }
}

Class Attr {
    hidden [hashtable]$Map = @{ }

    Attr() {}

    Attr([hashtable]$map) { $this.Map = $map }

    [bool] Equals([object]$other) {
        $keysMatch = -not (Compare-Object $this.Map.Keys $other.Map.Keys)
        $valsMatch = -not (Compare-Object $this.Map.Values $other.Map.Values)
        return $keysMatch -and $valsMatch
    }
}

Class Graph {
    hidden [Node[]] $Vertices = @()
    hidden [Edge[]] $Connections = @()
    hidden [Attr[]] $Properties = @()

    [Node[]]$Nodes  # Expose original names
    [Edge[]]$Edges
    [Attr[]]$Attrs

    Graph() {
        $this.Nodes = $this.Vertices
        $this.Edges = $this.Connections
        $this.Attrs = $this.Properties
    }

    Graph([object[]]$elements) {
        $this.Nodes = @()
        $this.Edges = @()
        $this.Attrs = @()
        $this.Vertices = @()
        $this.Connections = @()
        $this.Properties = @()

        foreach ($e in $elements) {
            switch ($e) {
                { $_ -is [Node] } { $this.Vertices += $_; $this.Nodes += $_ }
                { $_ -is [Edge] } { $this.Connections += $_; $this.Edges += $_ }
                { $_ -is [Attr] } { $this.Properties += $_; $this.Attrs += $_ }
                default { throw "Graph can only contain node, egde or attribute" }
            }
        }
    }
}
