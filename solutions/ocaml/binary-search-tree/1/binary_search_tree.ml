(* Dedicated to Junko F. Didi and Shree DR.MDD *)

open Base

type bst = Nil | Node of (int * bst * bst)

let empty = Nil

let value = function
  | Nil -> Result.fail "empty"
  | Node (num, _, _) -> Result.return num

let left = function
  | Nil -> Result.fail "empty"
  | Node (_, lnode, _) -> Result.return lnode

let right = function
  | Nil -> Result.fail "empty"
  | Node (_, _, rnode) -> Result.return rnode

let rec insert elem = function
  | Nil -> Node (elem, Nil, Nil)
  | Node (pivot, lnode, rnode) ->
      if elem <= pivot
      then Node (pivot, insert elem lnode, rnode)
      else Node (pivot, lnode, insert elem rnode)

let rec to_list = function
  | Nil -> []
  | Node (pivot, lnode, rnode) ->
      to_list lnode @ (pivot :: to_list rnode)
