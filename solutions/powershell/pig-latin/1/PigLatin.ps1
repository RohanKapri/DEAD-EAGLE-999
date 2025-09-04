Function Invoke-PigLatin() {
    [CmdletBinding()]
    Param(
        [string]$Text
    )

    @(switch -regex ($Text -split " ") {
        "^(xr|yt|[aeiou])" { "${_}ay"; continue }
        "^(y|[bcdfghjklmnprstvwxz]*qu|[bcdfghjklmnpqrstvwxz]+)(.*)" { "$($Matches[2])$($Matches[1])ay"; continue }
    }) -join " "
}
