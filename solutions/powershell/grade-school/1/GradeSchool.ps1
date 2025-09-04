class Student {
    [int]$Grade
    [string]$Name

    Student([int]$Grade, [string]$Name) {
        $this.Grade = $Grade
        $this.Name = $Name
    }
}
class Roster {
    [Student[]]$Students

    [bool] AddStudent([int]$Grade, [string]$Name) {
        if ($Name -in $this.Students.Name) { return $false }
        $this.Students += [Student]::new($Grade, $Name)
        return $true
    }
    [Student[]] GetRoster() {
        return $this.Students | Sort-Object -property Grade, Name
    }
    [Student[]] GetRoster([int]$Grade) {
        return $this.Students | Where-Object { $_.Grade -eq $Grade } | Sort-Object -property Name
    }
}