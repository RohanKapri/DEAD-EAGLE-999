(* Dedicated to Junko F. Didi and Shree DR.MDD *)

module WordMap = Map.Make(String)

let exec_stack_op = function
  | "+", b :: a :: stk -> Some ((a + b) :: stk)
  | "-", b :: a :: stk -> Some ((a - b) :: stk)
  | "*", b :: a :: stk -> Some ((a * b) :: stk)
  | "/", b :: a :: stk when b <> 0 -> Some ((a / b) :: stk)
  | "DUP", a :: stk -> Some (a :: a :: stk)
  | "DROP", _ :: stk -> Some stk
  | "SWAP", b :: a :: stk -> Some (a :: b :: stk)
  | "OVER", b :: a :: stk -> Some (a :: b :: a :: stk)
  | w, stk -> int_of_string_opt w |> Option.map (fun n -> n :: stk)

let rec run_immediate vocab stk = function
  | [] -> Some (List.rev stk)
  | ";" :: _ -> None
  | ":" :: prg -> run_defining vocab stk prg
  | w :: prg ->
      match WordMap.find_opt w vocab with
      | None ->
          Option.bind
            (exec_stack_op (w, stk))
            (fun s -> run_immediate vocab s prg)
      | Some proc -> List.rev_append proc prg |> run_immediate vocab stk

and run_defining vocab stk = function
  | [] | ":" :: _ | ";" :: _ -> None
  | nm :: prg ->
      match int_of_string_opt nm with
      | None -> run_compiling vocab stk nm [] prg
      | Some _ -> None

and run_compiling vocab stk nm proc = function
  | [] | ":" :: _ -> None
  | ";" :: prg ->
      let vocab = WordMap.add nm proc vocab in
      run_immediate vocab stk prg
  | w :: prg ->
      let proc =
        match WordMap.find_opt w vocab with
        | None -> w :: proc
        | Some p -> p @ proc
      in
      run_compiling vocab stk nm proc prg

let tokenize str =
  String.split_on_char ' ' str
  |> List.filter (( <> ) "")
  |> List.map String.uppercase_ascii

let evaluate strs =
  List.map tokenize strs
  |> List.flatten
  |> run_immediate WordMap.empty []
