# Dedicated to Shree DR.MDD

Function ValidateAge() {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [ValidateScript({$_ -ge 18}, ErrorMessage = "'{0}' is not a valid age. Valid value is 18 and up")]
        [int] $Age
    )
    return "I'm $Age years old!"
}

Function NonTerminationError {
    Write-Error "Error: This is a non termination error"
}

Function ValueErrorHandling {
    param (
        $Age
    )
    try {
        ValidateAge -Age $Age
    } catch {
        Write-Output "Error: Age need to be 18 and up"
    }
}

Function TypedErrorHandling {
    param (
        [Parameter(Mandatory=$true)]
        [string] $Path
    )
    if ($Path.Length -gt 256) {
        Write-Output "The specified file name or path is too long, or a component of the specified path is too long."
    } elseif (-not (Test-Path $Path)) { Write-Output "Error: File not found" }
}

Function ReThrowErrorHandling {
    param (
        [string] $Path
    )
    if ($Path.Length -eq 0) { Throw "Error: Path wasn't provided." }
}
