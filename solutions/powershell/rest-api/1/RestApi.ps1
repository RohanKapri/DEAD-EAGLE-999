Class RestAPI{
    [hashtable]$Database
    RestAPI([hashtable]$data) {
        $this.Database = @{}
        foreach ($user in $data.Users) { $this.Database[$user.name] = $user }
    }
    [object] Get([string]$url) { return $this.Get($url, $null) }
    [object] Get([string]$url, [string]$payload) {
        if ($url -ne "/users") { return $null }
        $data = ($payload ?? "{}") | ConvertFrom-Json
        return @{users = @($this.Database.Values | Where-Object { -not $data.users -or $_.name -in $data.users } |
            Sort-Object name)}
    }
    [object] Post([string]$url, [string]$payload) {
        $response = @{}
        $data = ($payload ?? "{}") | ConvertFrom-Json
        if ($url -eq "/add") {
            if ($this.Database.ContainsKey($data.user)) { throw "User already existed" }
            return ($this.Database[$data.user] = @{name = $data.user; owes = @{}; owed_by = @{}; balance = 0.0})
        } elseif ($url -eq "/iou") {
            $this.Update($this.Database[$data.borrower], $data.lender, -$data.amount)
            $this.Update($this.Database[$data.lender], $data.borrower, $data.amount)
            return @{users = $this.Database[$data.lender, $data.borrower] | Sort-Object name}
        }

        return $null
    }
    [void] hidden Update([hashtable]$user, [string]$name, [double]$amount) {
        $user.balance += $amount
        $diff = ($user.owed_by[$name] ?? 0.0) - ($user.owes[$name] ?? 0.0) + $amount
        $user.owed_by.Remove($name)
        $user.owes.Remove($name)
        if ($diff -gt 0) { $user.owed_by[$name] = $diff }
        elseif ($diff -lt 0) { $user.owes[$name] = -$diff }
    }
}