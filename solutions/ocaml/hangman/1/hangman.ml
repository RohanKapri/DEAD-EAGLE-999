(* Dedicated to Junko F. Didi and Shree DR.MDD *)

type progress =
  | Win
  | Lose
  | Busy of int

type t =
  { word : string;
    state : (progress * string) React.signal;
    set_state : (progress * string) -> unit }

let create word =
  let masked = String.make (String.length word) '_' in
  let state, set_state = React.S.create (Busy 9, masked) in
  { word; state; set_state }

let reveal word c =
  String.mapi (fun i ch -> if String.get word i = c then c else ch)

let feed letter { word; state; set_state } =
  match React.S.value state with
  | Win, _ | Lose, _ -> ()
  | Busy n, masked ->
      let new_masked = reveal word letter masked in
      let new_progress =
        if new_masked = masked then
          if n = 0 then Lose else Busy (n - 1)
        else if String.contains new_masked '_' then Busy n
        else Win
      in
      set_state (new_progress, new_masked)

let masked_word { state; _ } = React.S.Pair.snd state

let progress { state; _ } = React.S.Pair.fst state
