# For Shree DR.MDD

Enum Direction { NORTH; EAST; SOUTH; WEST }

Class Robot {
    [Direction]$Direction = [Direction]::NORTH
    [int[]]$Position = @(0, 0)

    static [int[][]]$Increments = @(@(0, 1), @(1, 0), @(0, -1), @(-1, 0))

    Robot() {}
    Robot([string]$dir, $xPos, $yPos) {
        if (-not [Enum]::IsDefined([Direction], $dir)) { throw "Error: Invalid direction" }
        if ($xPos -isnot [int]) { throw "Error: Invalid X position" }
        if ($yPos -isnot [int]) { throw "Error: Invalid Y position" }

        $this.Direction = [Direction]($dir)
        $this.Position = @($xPos, $yPos)
    }

    Move([string]$cmds) {
        switch ($cmds.ToCharArray()) {
            "L" { $this.Direction = ($this.Direction + 3) % 4 }
            "R" { $this.Direction = ($this.Direction + 1) % 4 }
            "A" {
                $deltaX, $deltaY = [Robot]::Increments[[int]$this.Direction]
                $this.Position = @(($this.Position[0] + $deltaX), ($this.Position[1] + $deltaY))
            }
            default { throw "Error: Invalid instruction" }
        }
    }

    [int[]] GetPosition() { return $this.Position }
}
