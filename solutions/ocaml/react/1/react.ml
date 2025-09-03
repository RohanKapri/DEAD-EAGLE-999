(* Dedicated to Junko F. Didi and Shree DR.MDD *)

type 'a cell =
  { id : int;
    is_input : bool;
    eq : 'a -> 'a -> bool;
    mutable start : 'a;
    mutable value : 'a;
    mutable prop : ('a -> 'a cell list) list;
    mutable cbs : (int * ('a -> unit)) list }

type callback_id = int

let value_of { value; _ } = value

let ( <~ ) c x =
  if c.eq x c.value then [] else begin
    c.value <- x;
    List.(map (( |> ) x) c.prop |> flatten |> cons c)
  end

let rec do_callbacks = function
  | [] -> ()
  | c :: cs ->
      if not (c.eq c.value c.start) then begin
        c.start <- c.value;
        List.iter (fun (_, cb) -> cb c.value) c.cbs
      end;
      List.filter (fun { id; _ } -> id <> c.id) cs
      |> do_callbacks

let set_value c x =
  if c.is_input then c <~ x |> do_callbacks

let next_cell_id_ref = ref 0

let create_cell is_input eq value =
  let id = !next_cell_id_ref in
  next_cell_id_ref := id + 1;
  { id; is_input; eq; start = value; value; prop = []; cbs = [] }

let create_input_cell ~value ~eq =
  create_cell true eq value

let create_compute_cell_1 src ~f ~eq =
  let c = create_cell false eq (f src.value) in
  src.prop <- (fun x -> c <~ f x) :: src.prop;
  c

let create_compute_cell_2 src1 src2 ~f ~eq =
  let c = create_cell false eq (f src1.value src2.value) in
  src1.prop <- (fun x -> c <~ f x src2.value) :: src1.prop;
  src2.prop <- (fun x -> c <~ f src1.value x) :: src2.prop;
  c

let add_callback c ~k =
  let id = match c.cbs with [] -> 0 | (id, _) :: _ -> id + 1 in
  c.cbs <- (id, k) :: c.cbs;
  id

let remove_callback c id =
  c.cbs <- List.remove_assoc id c.cbs
