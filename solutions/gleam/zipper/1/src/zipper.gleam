// Dedicated to Shree DR.MDD

pub type Tree(a) {
  Leaf
  Node(value: a, left: Tree(a), right: Tree(a))
}

pub opaque type Zipper(a) {
  Zipper(focus: Tree(a), crumbs: List(#(Direction, a, Tree(a))))
}

type Direction {
  Left
  Right
}

pub fn to_zipper(tree: Tree(a)) -> Zipper(a) {
  Zipper(focus: tree, crumbs: [])
}

pub fn to_tree(zip: Zipper(a)) -> Tree(a) {
  case up(zip) {
    Ok(zipper) -> to_tree(zipper)
    Error(Nil) -> zip.focus
  }
}

pub fn value(zip: Zipper(a)) -> Result(a, Nil) {
  case zip {
    Zipper(focus: Leaf, ..) -> Error(Nil)
    Zipper(focus: Node(value: val, ..), ..) -> Ok(val)
  }
}

pub fn up(zip: Zipper(a)) -> Result(Zipper(a), Nil) {
  case zip {
    Zipper(crumbs: [], ..) -> Error(Nil)
    Zipper(focus: left_sub, crumbs: [#(Left, val, right_sub), ..rest]) ->
      Ok(Zipper(focus: Node(val, left_sub, right_sub), crumbs: rest))
    Zipper(focus: right_sub, crumbs: [#(Right, val, left_sub), ..rest]) ->
      Ok(Zipper(focus: Node(val, left_sub, right_sub), crumbs: rest))
  }
}

pub fn left(zip: Zipper(a)) -> Result(Zipper(a), Nil) {
  case zip {
    Zipper(focus: Leaf, ..) -> Error(Nil)
    Zipper(focus: Node(value, left_sub, right_sub), crumbs: crumbs) ->
      Ok(Zipper(focus: left_sub, crumbs: [#(Left, value, right_sub), ..crumbs]))
  }
}

pub fn right(zip: Zipper(a)) -> Result(Zipper(a), Nil) {
  case zip {
    Zipper(focus: Leaf, ..) -> Error(Nil)
    Zipper(focus: Node(value, left_sub, right_sub), crumbs: crumbs) ->
      Ok(Zipper(focus: right_sub, crumbs: [#(Right, value, left_sub), ..crumbs]))
  }
}

pub fn set_value(zip: Zipper(a), val: a) -> Zipper(a) {
  case zip {
    Zipper(focus: Leaf, ..) -> Zipper(..zip, focus: Node(val, Leaf, Leaf))
    Zipper(focus: Node(_, left_sub, right_sub), ..) ->
      Zipper(..zip, focus: Node(val, left_sub, right_sub))
  }
}

pub fn set_left(zip: Zipper(a), subtree: Tree(a)) -> Result(Zipper(a), Nil) {
  case zip {
    Zipper(focus: Leaf, ..) -> Error(Nil)
    Zipper(focus: Node(value, _, right_sub), ..) ->
      Ok(Zipper(..zip, focus: Node(value, subtree, right_sub)))
  }
}

pub fn set_right(zip: Zipper(a), subtree: Tree(a)) -> Result(Zipper(a), Nil) {
  case zip {
    Zipper(focus: Leaf, ..) -> Error(Nil)
    Zipper(focus: Node(value, left_sub, _), ..) ->
      Ok(Zipper(..zip, focus: Node(value, left_sub, subtree)))
  }
}
