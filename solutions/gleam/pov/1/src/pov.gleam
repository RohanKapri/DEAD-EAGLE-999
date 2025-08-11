import gleam/list
import gleam/result

pub type Tree(a) {
  Tree(label: a, children: List(Tree(a)))
}

fn path_to_from_head(
  head: Tree(a),
  label: a,
  steps: List(a),
) -> Result(List(a), Nil) {
  case head.label == label {
    True -> Ok(steps)
    False ->
      case head.children {
        [] -> Error(Nil)
        c ->
          c
          |> list.map(fn(x) {
            path_to_from_head(x, label, list.prepend(steps, x.label))
          })
          |> list.find(result.is_ok)
          |> result.flatten
      }
  }
}

fn descend_restructure(head: Tree(a), steps: List(a)) -> Result(Tree(a), Nil) {
  case steps {
    [] -> Ok(head)
    [target_label, ..rest_steps] -> {
      use #(target, children_without_target) <- result.try(
        head.children
        |> list.pop(fn(x) { x.label == target_label }),
      )
      let head_without_child = Tree(..head, children: children_without_target)

      descend_restructure(
        Tree(
          ..target,
          children: list.prepend(target.children, head_without_child),
        ),
        rest_steps,
      )
    }
  }
}

pub fn from_pov(tree: Tree(a), from: a) -> Result(Tree(a), Nil) {
  use steps <- result.try(
    path_to_from_head(tree, from, [])
    |> result.map(list.reverse),
  )
  descend_restructure(tree, steps)
}

pub fn path_to(
  tree tree: Tree(a),
  from from: a,
  to to: a,
) -> Result(List(a), Nil) {
  use pov <- result.try(from_pov(tree, from))
  use path <- result.try(
    path_to_from_head(pov, to, [])
    |> result.map(list.reverse),
  )
  Ok([from, ..path])
}