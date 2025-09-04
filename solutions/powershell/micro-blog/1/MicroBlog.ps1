Function Invoke-MicroBlog() {
    [CmdletBinding()]
    Param(
        [string]$Post
    )
    -join ([Globalization.StringInfo]::GetTextElementEnumerator($Post) | Select-Object -first 5)
}