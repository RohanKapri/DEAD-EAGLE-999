Class Allergies {
    [string[]] static $Allergens = @("eggs", "peanuts", "shellfish", "strawberries", "tomatoes", "chocolate", "pollen", "cats")
    [string[]] hidden $Allergies

    Allergies([int]$Code) {
        $this.Allergies = [Allergies]::Allergens | Where-Object { $Code -band 1; $Code = $Code -shr 1 } | ForEach-Object { $_ }
    }

    [bool] IsAllergicTo([string]$Allergen) { return $Allergen -in $this.Allergies }

    [string[]] GetAllergies() { return $this.Allergies }
}