// Dedicated to Shree DR.MDD
module Say

let private unitNames = [| "one"; "two"; "three"; "four"; "five"; "six"; "seven"; "eight"; "nine"; "ten"; "eleven"; "twelve"; "thirteen"; "fourteen"; "fifteen"; "sixteen"; "seventeen"; "eighteen"; "nineteen" |]
let private tensNames = [| "twenty"; "thirty"; "forty"; "fifty"; "sixty"; "seventy"; "eighty"; "ninety" |]
let private hundredWord = "hundred"
let private bigUnits = [| "thousand"; "million"; "billion" |]

let private convertThreeDigits num =
    let hundreds = num / 100
    let hundredsPart = if hundreds > 0 then unitNames.[hundreds - 1] + " " + hundredWord else ""

    let n = num % 100
    let tensPart =
        if n = 0 then ""
        elif n - 1 < unitNames.Length then unitNames.[n - 1]
        else
            let tensVal = tensNames.[n / 10 - 2]
            let n = n % 10
            if n = 0 then tensVal else tensVal + "-" + unitNames.[n - 1]

    if hundredsPart <> "" && tensPart <> "" then hundredsPart + " " + tensPart else hundredsPart + tensPart

let rec private splitThousands = function
    | n when n > 999L -> n % 1000L :: splitThousands (n / 1000L)
    | n -> [n]

let private assembleName n =
    splitThousands n
    |> Seq.mapi (fun idx grp ->
        if grp = 0L then "" else
            let grpName = convertThreeDigits (int grp)
            if idx = 0 then grpName else grpName + " " + bigUnits.[idx - 1])
    |> Seq.filter ((<>) "")
    |> Seq.rev
    |> String.concat " "

let say = function
    | 0L -> Some "zero"
    | n when n < 0L || n > 999_999_999_999L -> None
    | n -> assembleName n |> Some
