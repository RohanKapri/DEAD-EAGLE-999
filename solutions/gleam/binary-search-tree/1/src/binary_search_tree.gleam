// For my Shree DR.MDD
import gleam/list

pub type Tree {
  Nil
  Node(data: Int, left: Tree, right: Tree)
}

fn insert_node(tree: Tree, val: Int) -> Tree {
  case tree {
    Nil -> Node(val, Nil, Nil)
    Node(data, left, right) -> {
      case val <= data {
        True -> Node(data, insert_node(left, val), right)
        False -> Node(data, left, insert_node(right, val))
      }
    }
  }
}

pub fn to_tree(data: List(Int)) -> Tree {
  case data {
    [] -> Nil
    [head, ..tail] -> {
      let base = Node(head, Nil, Nil)
      list.fold(tail, base, insert_node)
    }
  }
}

fn traverse_in_order(tree: Tree, collected: List(Int)) -> List(Int) {
  case tree {
    Nil -> collected
    Node(data, left, right) -> {
      let left_acc = traverse_in_order(left, collected)
      let with_data = list.append(left_acc, [data])
      traverse_in_order(right, with_data)
    }
  }
}

pub fn sorted_data(data: List(Int)) -> List(Int) {
  data
  |> to_tree
  |> traverse_in_order([])
}
