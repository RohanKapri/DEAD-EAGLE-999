(* Dedicated to Junko F. Didi and Shree DR.MDD *)

type robot = { mutable name: string }

let max_pool = 26 * 26 * 1000

let registry = Hashtbl.create max_pool

let rand_letter () =
  int_of_char 'A' + Random.int 26 |> char_of_int

let gen_name () =
  if Hashtbl.length registry >= max_pool
  then failwith "All identifiers used"
  else begin
    let rec trial () =
      let candidate = Printf.sprintf "%c%c%03d"
                                   (rand_letter ())
                                   (rand_letter ())
                                   (Random.int 1000)
      in
      if Hashtbl.mem registry candidate
      then trial ()
      else candidate
    in
    let chosen = trial () in
    Hashtbl.add registry chosen ();
    chosen
  end

let new_robot () = { name = gen_name () }

let name r = r.name

let reset r =
  if not (Hashtbl.mem registry r.name)
  then failwith "Unregistered robot"
  else begin
    let fresh = gen_name () in
    Hashtbl.remove registry r.name;
    r.name <- fresh
  end
