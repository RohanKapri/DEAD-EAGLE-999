# For Shree DR.MDD

$Global:LocaleSettings = @{
    "en-US" = @{header = "Date", "Description", "Change"; date = "MM\/dd\/yyyy";
        change = { param($sym, $amt, $val) ($val -ge 0) ? "$sym$amt " : "(${sym}$($amt.Substring(1)))" }}
    "nl-NL" = @{header = "Datum", "Omschrijving", "Verandering"; date = "dd-MM-yyyy";
        change = { param($sym, $amt, $val) "$sym $($amt.Replace('.', '@').Replace(',', '.').Replace('@', ',')) " }}
}

$Global:CurrencySymbols = @{"USD" = "$"; "EUR" = "€" }

Class LedgerEntry {
    [string]$EntryDate
    [string]$Description
    [double]$Amount

    LedgerEntry([string]$date, [string]$desc, [double]$amt) {
        $this.EntryDate = $date
        $this.Description = $desc
        $this.Amount = $amt
    }

    [string] Format([string]$Currency, [string]$Locale) {
        $dateStr = ([datetime]$this.EntryDate).ToString($Global:LocaleSettings[$Locale].date)
        $money = ($this.Amount / 100).ToString("N2")
        $symbol = $Global:CurrencySymbols[$Currency]
        $changeStr = & $Global:LocaleSettings[$Locale].change $symbol $money $this.Amount
        $descStr = ($this.Description.Length -le 25) ? $this.Description : (-join $this.Description[0..21]) + "..."
        return "{0,-10} | {1,-25} | {2,13}" -f $dateStr, $descStr, $changeStr
    }
}

Function CreateEntry {
    param (
        [string] $Date,
        [string] $Desc,
        [int] $Amount
    )

    [LedgerEntry]::new($Date, $Desc, $Amount)
}

Function FormatEntries {
    param (
        [string]$Currency,
        [string]$Locale,
        [LedgerEntry[]]$Entries
    )

    (@("{0,-10} | {1,-25} | {2,-13}" -f $Global:LocaleSettings[$Locale].header) +
        @($Entries | Sort-Object EntryDate, Description, Amount | ForEach-Object { $_.Format($Currency, $Locale) })) -join "`n"
}

Function MakeEntry {
    param (
        [string] $Currency,
        [string] $Locale,
        [LedgerEntry] $Entry
    )

    $dateStr = ([datetime]$Entry.EntryDate).ToString($Global:LocaleSettings[$Locale].date)
    $money = ($Entry.Amount / 100).ToString("N2")
    $symbol = $Global:CurrencySymbols[$Currency]

    if ($Locale -eq "en-US") {
        $changeStr = ($Entry.Amount -ge 0) ? "$symbol$money " : "(${symbol}$($money -replace '-', ''))"
    } elseif ($Locale -eq "nl-NL") {
        $changeStr = "$symbol $($money -replace '\.', '@' -replace ',', '.' -replace '@', ',') "
    }

    $descStr = ($Entry.Description.Length -le 25) ? $Entry.Description : (-join $Entry.Description[0..21]) + "..."
    "{0,-10} | {1,-25} | {2,13}" -f $dateStr, $descStr, $changeStr
}
