Class Forth {
    [int[]]$Stack = @()
    [hashtable]$Defs = @{}
    static [hashtable]$Ops = @{
        "+" = @{Size = 2; Func = {$this.Push($this.Pop() + $this.Pop()) }}
        "-" = @{Size = 2; Func = { $this.Push(-$this.Pop() + $this.Pop()) }}
        "*" = @{Size = 2; Func = { $this.Push($this.Pop() * $this.Pop()) }}
        "/" = @{Size = 2; Func = { $this.Push($this.Div($this.Pop(), $this.Pop())) }}
        "dup" = @{Size = 1; Func = { $this.Push($this.Stack[-1]) }}
        "drop" = @{Size = 1; Func = { $this.Pop() }}
        "swap" = @{Size = 2; Func = { $this.Push(@(($this.Pop()), ($this.Pop()))) }}
        "over" = @{Size = 2; Func = { $this.Push($this.Stack[-2]) }}
    }

    Forth() {}

    [void] Evaluate([string[]]$inputs) {
        $words = $inputs.ToLower().Split()
        for ($i = 0; $i -lt $words.Length;) {
            if (($word = $words[$i++]) -eq ":") {
                $iNext = [Array]::IndexOf($words, ";", $i)
                if ($iNext -lt $i + 1 -or $words[$i] -match '^-?\d') { throw "Illegal operation" }
                $this.defs[$words[$i]] = $words[($i + 1)..($iNext - 1)] | ForEach-Object { $this.defs[$_] ?? $_ }
                $i = $iNext + 1
            }
            elseif ($this.Defs.ContainsKey($word)) { $this.Evaluate($this.Defs[$word]) }
            elseif ([Forth]::Ops.ContainsKey($word)) {
                $this.CheckStack([Forth]::Ops[$word].Size)
                & ([Forth]::Ops[$word].Func)
            }
            elseif ($word -match '^-?\d+$') { $this.Push([int]::Parse($word)) }
            else { throw "Undefined operation" }
        }
    }

    [int[]] GetStack() { return $this.Stack }

    [void] hidden CheckStack([int]$size) {
        if (-not $this.Stack.Length) { throw "Stack is empty" }
        if ($this.Stack.Length -lt $size) { throw "Not enough items in stack to perform operation" }
    }

    [int] hidden Pop() {
        $value = $this.Stack[-1]
        $this.Stack = $this.Stack | Select-Object -SkipLast 1
        return $value
    }

    [void] hidden Push([object]$value) { $this.Stack += $value }

    [int] hidden Div([int]$den, [int]$num) {
        if ($den -eq 0) { throw "Can't divided by 0" }
        return [int][Math]::Floor($num / $den)
    }
}