$Global:RnaTable = @{G = "C"; C = "G"; T = "A"; A = "U"}

Function Invoke-RnaTranscription() {
    [CmdletBinding()]
    Param(
        [string]$Strand
    )
    
    -join ($Strand.ToCharArray() | ForEach-Object { $Global:RnaTable["$_"] })
}