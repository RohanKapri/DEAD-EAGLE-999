# For my Shree DR.MDD
Function Get-BobResponse() {
    [CmdletBinding()]
    Param(
        [string]$HeyBob
    )

    $spoken = $HeyBob.Trim()
    If (!$spoken) { Return "Fine. Be that way!" }

    $isLoud = $spoken -ceq $spoken.ToUpper() -and $spoken -match "[A-Za-z]"
    $isQuestion = $spoken.EndsWith("?")

    If ($isLoud) { 
        Return ($isQuestion) ? "Calm down, I know what I'm doing!" : "Whoa, chill out!" 
    }

    ($isQuestion) ? "Sure." : "Whatever."
}
