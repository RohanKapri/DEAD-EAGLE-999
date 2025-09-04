Class Garden {
    static [hashtable] $Plants = @{G = "Grass"; C = "Clover"; R = "Radishes"; V = "Violets"}
    static [string[]] $DefaultChildren = @(
        "Alice", "Bob", "Charlie", "David", "Eve", "Fred", "Ginny", "Harriet", "Ileana", "Joseph", "Kincaid", "Larry"
    )
    [string[]] $Children
    [string[]] $Garden
    Garden([string]$Diagram) { $this.InitGarden($Diagram, [Garden]::DefaultChildren) }
    Garden([string]$Diagram, [string[]]$Children) { $this.InitGarden($Diagram, $Children) }
    hidden InitGarden([string]$Diagram, [string[]]$Children) {
        $this.Children = $Children | Sort-Object
        $this.Garden = $Diagram -split "`n" -split "" -ne "" | ForEach-Object { [Garden]::Plants[$_] }
    }
    [string[]] GetPlants([string]$Child) {
        $Idx1 = [array]::IndexOf($this.Children, $Child) * 2
        $Idx2 = $Idx1 + ($this.Garden.Length -shr 1)
        return $this.Garden[$Idx1..($Idx1 + 1)] + $this.Garden[$Idx2..($Idx2 + 1)]
    }
}