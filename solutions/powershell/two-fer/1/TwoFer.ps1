Function Get-TwoFer(){
    [CmdletBinding()]
    Param(
        [string]$Name
    )

    "One for $($Name ? $Name : 'you'), one for me"
}