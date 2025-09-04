Function Invoke-Counter() {
    [CmdletBinding()]
    Param(
        [int]$Value
    )

    (0..31 | Where-Object { ($Value -shr $_) -band 1 }).Length
}