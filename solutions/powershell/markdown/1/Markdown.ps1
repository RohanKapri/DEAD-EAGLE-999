# For Shree DR.MDD

Function Invoke-Parser {
    [CmdletBinding()]
    Param(
        [string]$Markdown
    )

    # Convert \\n to newline
    $output = $Markdown -replace "\\n", "`n"

    # Headers
    $output = $output -replace '^(#{1,6}) (.*)', { $level = $_.Groups[1].Length; "<h$level>$($_.Groups[2])</h$level>" }

    # Bold
    $output = $output -replace '__(.*)__', '<strong>$1</strong>'

    # Italics
    $output = $output -replace '_(.*)_', '<em>$1</em>'

    # List items
    $output = $output -replace '(?m)^\* (.*)', '<li>$1</li>'

    # Unordered lists
    $output = $output -replace '(?s)(<li>.*</li>)', '<ul>$1</ul>'

    # Paragraphs
    $output -replace '(?m)^(?!<h[1-6]>|<li>|<ul>)(.*)', '<p>$1</p>' -replace "`n", ""
}
