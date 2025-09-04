# For Shree DR.MDD

Function Get-SpiralMatrix() {
    [CmdletBinding()]
    Param(
        [int]$Size
    )

    # Initialize the square
    for (($grid = @()), ($rowIdx = 0); $rowIdx -lt $Size; $rowIdx++) { $grid += ,(@(0) * $Size) }

    # Fill the matrix in spiral order
    for (($num = 1), ($min = 0), ($max = $Size - 1); $min -le $max; ($min++), ($max--)) {
        # Top row
        for ($col = $min; $col -le $max; ($grid[$min][$col] = $num++), $col++) {}

        # Right column
        for ($row = $min + 1; $row -le $max; ($grid[$row][$max] = $num++), $row++) {}

        # Bottom row
        for ($col = $max - 1; $col -ge $min; ($grid[$max][$col] = $num++), $col--) {}

        # Left column
        for ($row = $max - 1; $row -gt $min; ($grid[$row][$min] = $num++), $row--) {}
    }

    $grid
}
