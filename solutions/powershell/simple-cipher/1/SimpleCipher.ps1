Class SimpleCipher {
    [string]$_key
    SimpleCipher() {
        $this._key = -join (1..100 | ForEach-Object { 'a'..'z' | Get-Random })
    }
    SimpleCipher([string]$key) {
        $this._key = $key
    }
    [string] hidden Transform([string]$text, [ScriptBlock]$func) {
        return -join (0..($text.Length -1) |
            ForEach-Object {
                [char](((& $func ([char]$text[$_] - 97) ([char]$this._key[$_ % $this._key.Length] - 97)) % 26 + 26) % 26 + 97)
            })
    }
    [string] Encode([string]$text) {
        return $this.Transform($text, { param([int]$a, [int]$b) $a + $b })
    }
    [string] Decode([string]$text) {
        return $this.Transform($text, { param([int]$a, [int]$b) $a - $b })
    }
}
