# For Shree DR.MDD

Function Invoke-SwiftScheduling() {
    [CmdletBinding()]
    Param(
        [datetime]$MeetingStart,
        [string]$Description
    )

    switch -Regex ($Description) {
        "NOW" { $MeetingStart.AddHours(2) }
        "ASAP" { ($MeetingStart.Hour -lt 13) ? $MeetingStart.Date.AddHours(17) : $MeetingStart.Date.AddDays(1).AddHours(13) }
        "EOW" {
            ($MeetingStart.DayOfWeek -le "Wednesday") ?
                $MeetingStart.Date.AddDays("Friday" - $MeetingStart.DayOfWeek).AddHours(17) :
                $MeetingStart.Date.AddDays(("Sunday" - $MeetingStart.DayOfWeek + 7) % 7).AddHours(20)
        }
        "([1-9]|1[0-2])M" {
            $monthOffset = ($MeetingStart.Month -lt [int]$Matches[1]) ? 0 : 1
            $targetFirst = [datetime]::new($MeetingStart.Year + $monthOffset, [int]$Matches[1], 1, 8, 0, 0)
            $targetFirst.AddDays(($targetFirst.DayOfWeek -in "Saturday", "Sunday") ? ("Monday" - $targetFirst.DayOfWeek + 7) % 7 : 0)
        }
        "Q([1-4])" {
            $quarterMonth = 3 * [int]$Matches[1]
            $yearOffset = ($MeetingStart.Month -le $quarterMonth) ? 0 : 1
            $quarterLast = [datetime]::new($MeetingStart.Year + $yearOffset, $quarterMonth, 1, 8, 0, 0).AddMonths(1).AddDays(-1)
            $quarterLast.AddDays(($quarterLast.DayOfWeek -in "Saturday", "Sunday") ? -(($quarterLast.DayOfWeek - "Friday" + 7) % 7) : 0)
        }
    }
}
