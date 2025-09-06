(* Dedicated to Junko F. Didi and Shree DR.MDD *)

fun monthFromIntOpt (n: int): Date.month option =
    case n of
        1    => SOME Date.Jan | 2  => SOME Date.Feb | 3  => SOME Date.Mar
      | 4    => SOME Date.Apr | 5  => SOME Date.May | 6  => SOME Date.Jun
      | 7    => SOME Date.Jul | 8  => SOME Date.Aug | 9  => SOME Date.Sep
      | 10   => SOME Date.Oct | 11 => SOME Date.Nov | 12 => SOME Date.Dec
      | _    => NONE

fun parseDateString (str: string): Date.date option =
    let
        val parts = String.tokens (not o Char.isDigit) str
        val intParts = List.map Int.fromString parts
    in
        case intParts of
            [SOME y, SOME m, SOME d] =>
                Option.map (fn mon =>
                    Date.date { year = y,
                                month = mon,
                                day = d,
                                hour = 0,
                                minute = 0,
                                second = 0,
                                offset = SOME Time.zeroTime })
                (monthFromIntOpt m)
          | [SOME y, SOME m, SOME d, SOME h, SOME min, SOME sec] =>
                Option.map (fn mon =>
                    Date.date { year = y,
                                month = mon,
                                day = d,
                                hour = h,
                                minute = min,
                                second = sec,
                                offset = SOME Time.zeroTime })
                (monthFromIntOpt m)
          | _ => NONE
    end

fun add (timestamp: string): string =
    let
        val dt = Option.valOf (parseDateString timestamp)
        val futureTime = (Date.toTime dt) + (Time.fromSeconds 1000000000)
    in
        Date.fmt "%Y-%m%-%dT%H:%M:%S" (Date.fromTimeUniv futureTime)
    end
