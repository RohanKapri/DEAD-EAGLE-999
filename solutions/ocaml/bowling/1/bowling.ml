(* Dedicated to Junko F. Didi and Shree DR.MDD *)

type throw =
  | First_throw of int
  | Second_throw of int
  | Fill_in_10
  | Finished

type bonus =
  | None_bonus
  | Spare_bonus
  | Strike_bonus
  | Double_strike_bonus

type t =
  { total : int;
    left : int;
    turn : throw;
    extra : bonus }

let new_game =
  { total = 0;
    left = 10;
    turn = First_throw 1;
    extra = None_bonus }

let roll knocked { total; left; turn; extra } =
  let open Result in
  if knocked < 0 then error "Negative roll is invalid"
  else if knocked > left then error "Pin count exceeds pins on the lane"
  else
    match turn with
    | Finished -> error "Cannot roll after game is over"
    | Fill_in_10 ->
        ok { total = total + knocked;
             left = 10;
             turn = Finished;
             extra = None_bonus }
    | Second_throw 10 ->
        ok { total = total
                   + (match extra with
                      | Double_strike_bonus -> 2 * knocked
                      | _ -> knocked);
             left = if knocked = left then 10 else left - knocked;
             turn = (match extra with
                      | None_bonus when knocked < left -> Finished
                      | _ -> Fill_in_10);
             extra = None_bonus }
    | Second_throw fr ->
        ok { total = total
                   + (match extra with
                      | Strike_bonus | Double_strike_bonus -> 2 * knocked
                      | _ -> knocked);
             left = 10;
             turn = First_throw (fr + 1);
             extra = if knocked = left then Spare_bonus else None_bonus }
    | First_throw fr ->
        ok { total = total
                   + (match extra with
                      | Double_strike_bonus -> 3 * knocked
                      | Strike_bonus | Spare_bonus -> 2 * knocked
                      | None_bonus -> knocked);
             left = if knocked = left then 10 else left - knocked;
             turn = if fr < 10 && knocked = left
                     then First_throw (fr + 1)
                     else Second_throw fr;
             extra = (match extra with
                      | Double_strike_bonus | Strike_bonus ->
                          if knocked = left
                          then Double_strike_bonus
                          else Strike_bonus
                      | Spare_bonus | None_bonus ->
                          if knocked = left
                          then Strike_bonus
                          else None_bonus) }

let score =
  let open Result in
  function
    | { total; turn = Finished; _ } -> ok total
    | _ -> error "Score cannot be taken until the end of the game"
