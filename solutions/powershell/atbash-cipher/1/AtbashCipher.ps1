# Dedicated to my Shree DR.MDD

function Transliterate-AtbashChar([char]$ch)
{
    if (-not [char]::IsAsciiLetter($ch))
    {
        return $ch
    }

    $pos = [int]$ch -band ((1 -shl 5) - 1)
    return [char](96 + 26 - $pos + 1)
}

function Transliterate-AtbashString([string]$txt)
{
    $sb = [System.Text.StringBuilder]::new()
    for ($idx = 0; $idx -lt $txt.Length; $idx++)
    {
        if ([Char]::IsLetterOrDigit($txt[$idx]))
        {
            [void]$sb.Append((Transliterate-AtbashChar $txt[$idx]))
        }
    }

    return $sb.ToString()
}

function Invoke-Encode([string]$Phrase)
{
    $encoded = Transliterate-AtbashString $Phrase
    $pieces = [System.Collections.Generic.List[string]]::new()
    for ($i = 0; $i -lt $encoded.Length; $i += 5)
    {
        [void]$pieces.Add($i + 5 -gt $encoded.Length ? $encoded.Substring($i) : $encoded.Substring($i, 5))
    }

    return [string]::Join(" ", $pieces)
}

function Invoke-Decode([string]$Phrase)
{
    return Transliterate-AtbashString $Phrase
}
