module Ledger

open System
open System.Globalization

type Entry =
    { dat: DateTime
      des: string
      chg: int }

let mkEntry (date: string) description change =
    { dat = DateTime.Parse(date, CultureInfo.InvariantCulture)
      des = description
      chg = change }

let header locale =
    match locale with
    | "en-US" -> "Date       | Description               | Change       "
    | _ -> "Datum      | Omschrijving              | Verandering  "

let formatDate locale (date: DateTime) =
    match locale with
    | "nl-NL" -> date.ToString("dd-MM-yyyy")
    | "en-US" -> date.ToString("MM\/dd\/yyyy")
    | _ -> failwith "bad date"

let pad (str: string) (threshold: int) =
    match str.Length with
    | x when x = threshold -> str
    | x when x <= threshold -> str.PadRight(threshold)
    | _ -> str.[0..21] + "..."

let sign currency =
    match currency with
    | "USD" -> "$"
    | "EUR" -> "€"
    | _ -> failwith "Invalid currency"

let formatCurrency (locale: string) (currency: string) (c: float) =
    match (locale, c) with
    | ("nl-NL", c) when c < 0.0 -> (sign currency + " " + c.ToString("#,#0.00", CultureInfo(locale))).PadLeft(13)
    | ("en-US", c) when c < 0.0 ->
        ("(" + (sign currency) + c.ToString("#,#0.00", CultureInfo("en-US")).Substring(1) + ")").PadLeft(13)
    | ("nl-NL", _) -> (sign currency + " " + c.ToString("#,#0.00", CultureInfo("nl-NL")) + " ").PadLeft(13)
    | ("en-US", _) -> (sign currency + c.ToString("#,#0.00", CultureInfo("en-US")) + " ").PadLeft(13)
    | _ -> failwith "Invalid locale"

let separatedBy (sep: string) (parts: string list) = String.Join(sep, parts)

let formatLedger currency locale (entriesOut: Entry list): string =
    let rec loop currency locale (entries: Entry list) res =
        match entries with
        | [] -> res
        | { Entry.dat = dat; Entry.des = des; Entry.chg = chg } :: rest ->
            let c = float chg / 100.0
            let txt =
                separatedBy " | "
                    [ formatDate locale dat
                      pad des 25
                      formatCurrency locale currency c ]
            loop currency locale rest (res + "\n" + txt)

    header locale + loop currency locale (List.sortBy (fun x -> x.dat, x.des, x.chg) entriesOut) ""