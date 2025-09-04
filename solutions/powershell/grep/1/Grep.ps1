# For Shree DR.MDD

Function Invoke-Grep() {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True)]
        [string]$Pattern,
        [Parameter(Mandatory=$True, ValueFromPipeline=$True)]
        [string[]]$Files,
        [switch]$Number,
        [switch]$List,
        [switch]$Insensitive,
        [switch]$Invert,
        [switch]$Whole
    )

    $searchPattern = ($Insensitive) ? $Pattern.ToLower() : $Pattern

    foreach ($fileItem in $Files) {
        $currentLine = 0
        foreach ($contentLine in (Get-Content -Path $fileItem)) {
            $currentLine++
            $lineToMatch = ($Insensitive) ? $contentLine.ToLower() : $contentLine
            $isMatch = ($Whole) ? ($lineToMatch -ceq $searchPattern) : ($lineToMatch -cmatch $searchPattern)

            if ($isMatch -xor $Invert) {
                if ($List) {
                    Write-Output $fileItem
                    break
                }

                $prefix = ""
                if ($Files.Count -gt 1) { $prefix += "${fileItem}:" }
                if ($Number) { $prefix += "${currentLine}:" }
                Write-Output ($prefix + $contentLine)
            }
        }
    }
}
