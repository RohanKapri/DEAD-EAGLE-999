(* Dedicated to Junko F. Didi and Shree DR.MDD *)

open Base
open CalendarLib

type schedule = First | Second | Third | Fourth | Teenth | Last

type weekday = Monday | Tuesday | Wednesday | Thursday
             | Friday | Saturday | Sunday

type date = int * int * int

let weekday_diff (w1: weekday) (w2: weekday): int =
  let to_int = function
    | Monday -> 0
    | Tuesday -> 1
    | Wednesday -> 2
    | Thursday -> 3
    | Friday -> 4
    | Saturday -> 5
    | Sunday -> 6
  in
  (to_int w1 - to_int w2) % 7

let weekday_of_date (d: Date.t): weekday =
  match Date.day_of_week d with
  | Sun -> Sunday
  | Mon -> Monday
  | Tue -> Tuesday
  | Wed -> Wednesday
  | Thu -> Thursday
  | Fri -> Friday
  | Sat -> Saturday

let schedule_index = function
  | First -> 0
  | Second -> 1
  | Third -> 2
  | Fourth -> 3
  | Teenth -> 4
  | Last -> 5

let add_days_to_date base n =
  Date.Period.day n |> Date.add base

let meetup_day sched wd ~year ~month =
  let start_date = Date.make year month 1 in
  let compute_offset start = start + weekday_diff wd (add_days_to_date start_date start |> weekday_of_date) in
  let day = compute_offset @@ match sched with
    | Teenth -> 12
    | Last -> 21 + max 0 (Date.days_in_month start_date - 28)
    | _ -> 7 * schedule_index sched
  in
  let result_date = add_days_to_date start_date day in
  (Date.year result_date,
   Date.month result_date |> Date.int_of_month,
   Date.day_of_month result_date)
