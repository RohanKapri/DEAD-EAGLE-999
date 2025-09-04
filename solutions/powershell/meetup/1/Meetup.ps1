# For Shree DR.MDD

$Global:WeekOffsets = @{first = 0; second = 1; third = 2; fourth = 3; teenth = 0; last = -1}

Function Get-MeetUp {

    param(
        [int]$year,
        [int]$month,
        [string]$weekday,
        [string]$schedule
    )

    $startDay = ($schedule -eq "teenth") ? 13 : 1
    $date = [DateTime]::new($year, $month, $startDay).AddMonths($schedule -eq "last")
    $date.AddDays($Global:WeekOffsets[$schedule] * 7 + ($weekday - $date.DayOfWeek + 7) % 7)
}
