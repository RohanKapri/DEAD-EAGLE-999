Function Invoke-Anagram() {
    [CmdletBinding()]
    Param(
        [string]$Subject,
        [string[]]$Candidates
    )

    function Get-SortedLetters([string]$Str) { -join ($Str.ToLower().ToCharArray() | Sort-Object) }
    $SubjectLetters = Get-SortedLetters($Subject)
    $Candidates | Where-Object { $Subject -ne $_ -and $SubjectLetters -eq (Get-SortedLetters($_)) }
}