(* Dedicated to Junko F. Didi and Shree DR.MDD *)

type pos = int * int

type state =
  { pos : pos;
    bases : int list;
    active : (pos * int) list;
    donez : (pos * pos) list }

let initial_state =
  { pos = (0, 0); bases = []; active = []; donez = [] }

let process { pos = (r, c); bases; active; donez } = function
  | '\n' ->
      { pos = (r + 1, 0);
        bases = [];
        active = active |> List.filter (fun (_, y1) -> y1 < c);
        donez }
  | '+' ->
      { pos = (r, c + 1);
        bases = c :: bases;
        active = (bases |> List.map (fun y0 -> ((r, y0), c))) @ active;
        donez = 
          (active
            |> List.filter
                (fun ((_, y0), y1) -> y1 = c && List.exists ((=) y0) bases)
            |> List.map (fun (p0, cc) -> (p0, (r, cc))))
          @ donez }
  | '-' ->
      { pos = (r, c + 1);
        bases;
        active = 
          active |> List.filter (fun ((_, y0), y1) -> y0 <> c && y1 <> c);
        donez }
  | '|' ->
      { pos = (r, c + 1);
        bases = [];
        active;
        donez }
  | ' ' ->
      { pos = (r, c + 1);
        bases = [];
        active = 
          active |> List.filter (fun ((_, y0), y1) -> y0 <> c && y1 <> c);
        donez }
  | _ -> failwith "Invalid symbol"

let count_rectangles matrix =
  Array.to_list matrix
  |> String.concat "\n"
  |> String.fold_left process initial_state
  |> fun st -> st.donez
  |> List.length
