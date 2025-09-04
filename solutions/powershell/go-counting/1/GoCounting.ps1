# For Shree DR.MDD

Enum Owner {
    BLACK
    WHITE
    NONE
    UNKNOWN
}

Class Board {
    [string[]]$boardState
    [string[]]$currentState

    Board([string[]]$inputBoard) {
        $this.boardState = $inputBoard
        $this.currentState = $inputBoard
    }

    [Owner] DetermineOwner([PSCustomObject]$territoryObj, [int]$col, [int]$row) {
        if ($this.currentState[$row][$col] -ne '*') {
            if ($territoryObj.Owner -eq [Owner]::UNKNOWN) {
                if ($this.currentState[$row][$col] -eq 'B') { return [Owner]::BLACK }
                else { return [Owner]::WHITE }
            } else {
                if ($territoryObj.Owner -ne [Owner]::NONE) {
                    if (($this.currentState[$row][$col] -eq 'B' -and $territoryObj.Owner -eq [Owner]::WHITE) -or
                        ($this.currentState[$row][$col] -eq 'W' -and $territoryObj.Owner -eq [Owner]::BLACK)) {
                        return [Owner]::NONE
                    }
                }
            }
        }
        return $territoryObj.Owner
    }

    [PSCustomObject] ExploreTerritory([PSCustomObject]$territoryObj, [int]$col, [int]$row) {
        if ($territoryObj.Coordinates.Count -eq 0) { $territoryObj.Coordinates = @(,@($col,$row)) }
        else { $territoryObj.Coordinates += ,@($col,$row) }

        $this.currentState[$row] = $this.currentState[$row].Insert($col,"*").Remove($col+1,1)

        if ($row -gt 0) {
            if ($this.currentState[$row-1][$col] -eq " ") { $territoryObj = $this.ExploreTerritory($territoryObj,$col,$row-1) }
            else { $territoryObj.Owner = $this.DetermineOwner($territoryObj,$col,$row-1) }
        }
        if ($col -gt 0) {
            if ($this.currentState[$row][$col-1] -eq " ") { $territoryObj = $this.ExploreTerritory($territoryObj,$col-1,$row) }
            else { $territoryObj.Owner = $this.DetermineOwner($territoryObj,$col-1,$row) }
        }
        if ($row -lt $this.currentState.Count-1) {
            if ($this.currentState[$row+1][$col] -eq " ") { $territoryObj = $this.ExploreTerritory($territoryObj,$col,$row+1) }
            else { $territoryObj.Owner = $this.DetermineOwner($territoryObj,$col,$row+1) }
        }
        if ($col -lt $this.currentState[$row].Length-1) {
            if ($this.currentState[$row][$col+1] -eq " ") { $territoryObj = $this.ExploreTerritory($territoryObj,$col+1,$row) }
            else { $territoryObj.Owner = $this.DetermineOwner($territoryObj,$col+1,$row) }
        }
        return $territoryObj
    }

    [PSCustomObject] Territory([int[]]$coordinate) {
        if ($coordinate[0] -lt 0 -or $coordinate[0] -ge $this.currentState[0].Length -or
            $coordinate[1] -lt 0 -or $coordinate[1] -ge $this.currentState.Count) {
            throw "*Invalid coordinate*"
        }
        $territoryObj = @{Owner = [Owner]::UNKNOWN; Coordinates = @()}

        if ($this.currentState[$coordinate[1]][$coordinate[0]] -eq " ") {
            $territoryObj = $this.ExploreTerritory($territoryObj,$coordinate[0],$coordinate[1])
            $territoryObj.Coordinates = @($territoryObj.Coordinates | Sort-Object)
        } else {
            $territoryObj = @{Owner = [Owner]::NONE; Coordinates = @()}
        }
        return $territoryObj
    }

    [PSCustomObject] Territories() {
        $territories = @{BLACK = @(); WHITE = @(); NONE = @()}
        for ($row = 0; $row -lt $this.currentState.Count; $row++) {
            for ($col = 0; $col -lt $this.currentState[$row].Length; $col++) {
                if ($this.currentState[$row][$col] -eq " ") {
                    $territoryObj = @{Owner = [Owner]::UNKNOWN; Coordinates = @()}
                    $territoryObj = $this.ExploreTerritory($territoryObj,$col,$row)
                    if ($territoryObj.Owner -eq [Owner]::BLACK) { $territories.BLACK += $territoryObj.Coordinates }
                    if ($territoryObj.Owner -eq [Owner]::WHITE) { $territories.WHITE += $territoryObj.Coordinates }
                    if ($territoryObj.Owner -eq [Owner]::NONE -or $territoryObj.Owner -eq [Owner]::UNKNOWN) { $territories.NONE += $territoryObj.Coordinates }
                }
            }
        }
        return $territories
    }
}
