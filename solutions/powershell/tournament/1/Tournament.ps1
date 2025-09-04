Function Invoke-Tournament {
    [CmdletBinding()]
    Param(
        [string[]]$Results
    )
    $teams = @{}
    foreach ($result in $Results) {
        $team1, $team2, $outcome = $result -split ";"
        $teams[$team1] = Get-Score $teams[$team1] ($outcome -eq "win") ($outcome -eq "draw") ($outcome -eq "loss")
        $teams[$team2] = Get-Score $teams[$team2] ($outcome -eq "loss") ($outcome -eq "draw") ($outcome -eq "win")
    }
    (@("Team                           | MP |  W |  D |  L |  P") +
        ($teams.GetEnumerator() | Sort-Object -Property { -$_.Value[4] }, Key |
        ForEach-Object { "{0,-30} | {1,2} | {2,2} | {3,2} | {4,2} | {5,2}" -f (@($_.Key) + $_.Value) })) -join "`n"
}
Function Get-Score([object] $current, [boolean]$win, [boolean]$draw, [boolean]$loss) {
    $current = $current ?? @(0, 0, 0, 0, 0)
    @(($current[0] + 1), ($current[1] + $win), ($current[2] + $draw), ($current[3] + $loss), ($current[4] + 3 * $win + $draw))
}