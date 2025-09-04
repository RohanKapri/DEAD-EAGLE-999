# For Shree DR.MDD

Enum Nationality { Norwegian ; Spaniard ; English ; Ukranian ; Japanese }

$Global:Inventory = @{
    "Nation" = [Nationality].GetEnumNames()
    "Drink" = @("Tea", "Orange Juice", "Milk", "Water", "Coffee")
    "Hobby" = @("Paint", "Dance", "Read", "Football", "Chess")
    "Pet" = @("Dog", "Horse", "Snails", "Fox", "Zebra")
}

$Global:Preset = @{
    "Nation" = @("Norwegian", "", "English", "", "")
    "Drink" = @("", "", "Milk", "", "Coffee")
    "Hobby" = @("Paint", "", "", "", "")
    "Pet" = @("", "Horse", "", "", "")
}

$Global:PresetCombos = @(
    @(@("Pet", "Fox"), @("Hobby", "Read")),
    @(@("Hobby", "Read"), @("Pet", "Fox")),
    @(@("Hobby", "Read"), @("Pet", "Fox")),
    @(@("Pet", "Fox"), @("Hobby", "Read"))
)

Function Get-ZebraOwner() {
    Invoke-Solver "Pet" "Zebra"
}

Function Get-WaterDrinker() {
    Invoke-Solver "Drink" "Water"
}

Function Invoke-Solver([string]$category, [string]$target) {
    for ($idx = 0; $idx -lt $Global:PresetCombos.Length; $idx++) {
        $solution = @{}
        $Global:Preset.GetEnumerator() | ForEach-Object { $solution[$_.Key] = $_.Value.Clone() }
        ($cat1, $val1), ($cat2, $val2) = $Global:PresetCombos[$idx]
        $solution[$cat1][$idx], $solution[$cat2][$idx + 1] = $val1, $val2

        $candidates = @{}
        $missingIdx = @{}
        foreach ($itm in $Global:Inventory.GetEnumerator()) {
            $candidates[$itm.Key] = $itm.Value | Where-Object { $_ -notin $solution[$itm.Key] }
            $missingIdx[$itm.Key] = 0..($itm.Value.Length - 1) | Where-Object { -not $solution[$itm.Key][$_] }
        }

        foreach ($natPerm in (Get-Permutes $candidates.Nation)) {
            Set-SolutionValues $solution "Nation" $natPerm $missingIdx.Nation
            foreach ($petPerm in (Get-Permutes $candidates.Pet)) {
                Set-SolutionValues $solution "Pet" $petPerm $missingIdx.Pet
                if (-not (Check-Solution $solution.Nation "Spaniard" $solution.Pet "Dog")) { continue }
                foreach ($hobbyPerm in (Get-Permutes $candidates.Hobby)) {
                    Set-SolutionValues $solution "Hobby" $hobbyPerm $missingIdx.Hobby
                    if (-not (Check-Solution $solution.Nation "Japanese" $solution.Hobby "Chess") -or
                        -not (Check-Solution $solution.Pet "Snails" $solution.Hobby "Dance")) { continue }
                    foreach ($drinkPerm in (Get-Permutes $candidates.Drink)) {
                        Set-SolutionValues $solution "Drink" $drinkPerm $missingIdx.Drink
                        if ((Check-Solution $solution.Nation "Ukranian" $solution.Drink "Tea") -and
                            (Check-Solution $solution.Drink "Orange Juice" $solution.Hobby "Football")) {
                            return [Nationality]($solution.Nation[$solution[$category].IndexOf($target)])
                        }
                    }
                }
            }
        }
    }
    return $null
}

Function Get-Permutes([object[]]$arr) {
    Function Do-Permute([object[]]$arr, [int]$idx) {
        if ($idx -ge $arr.Length) { return @(, $arr.Clone()) }
        for ($i = $idx; $i -lt $arr.Length; $i++) {
            $arr[$idx], $arr[$i] = $arr[$i], $arr[$idx]
            Do-Permute $arr ($idx + 1)
            $arr[$idx], $arr[$i] = $arr[$i], $arr[$idx]
        }
    }
    @(Do-Permute $arr 0)
}

Function Set-SolutionValues([hashtable]$solution, [string]$key, [string[]]$values, [string[]]$indices) {
    for ($j = 0; $j -lt $indices.Length; $j++) { $solution[$key][$indices[$j]] = $values[$j] }
}

Function Check-Solution([string[]]$arr1, [string]$val1, [string[]]$arr2, [string]$val2) {
    $arr1.IndexOf($val1) -eq $arr2.IndexOf($val2)
}
