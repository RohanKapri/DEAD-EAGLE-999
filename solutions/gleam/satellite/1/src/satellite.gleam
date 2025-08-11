// For my Shree DR.MDD
import gleam/list
import gleam/set

pub type Tree(a) {
  Nil
  Node(value: a, left: Tree(a), right: Tree(a))
}

pub type Error {
  DifferentLengths
  DifferentItems
  NonUniqueItems
}

fn index_of(lst: List(a), val: a) -> Int {
  list.index_fold(lst, -1, fn(acc, elt, idx) {
    case elt == val {
      True -> idx
      False -> acc
    }
  })
}

fn construct_tree(pre: List(a), ino: List(a)) -> Result(Tree(a), Error) {
  case pre {
    [] -> Ok(Nil)
    [root, ..tail] -> {
      let root_pos = index_of(ino, root)
      case root_pos >= 0 {
        False -> Error(DifferentItems)
        True -> {
          let #(left_ino, right_ino) = list.split(ino, root_pos)
          let right_ino = list.drop(right_ino, 1)
          let left_len = list.length(left_ino)
          let #(left_pre, right_pre) = list.split(tail, left_len)
          case construct_tree(left_pre, left_ino), construct_tree(right_pre, right_ino) {
            Ok(left), Ok(right) -> Ok(Node(root, left, right))
            _, _ -> Error(DifferentItems)
          }
        }
      }
    }
  }
}

pub fn tree_from_traversals(
  inorder inorder: List(a),
  preorder preorder: List(a),
) -> Result(Tree(a), Error) {
  case list.length(inorder) == list.length(preorder) {
    False -> Error(DifferentLengths)
    True -> {
      let in_set = set.from_list(inorder)
      let pre_set = set.from_list(preorder)
      case set.size(in_set) == list.length(inorder) && set.size(pre_set) == list.length(preorder) {
        False -> Error(NonUniqueItems)
        True -> {
          let all_present = list.all(inorder, fn(x) { list.contains(preorder, x) })
          case all_present {
            False -> Error(DifferentItems)
            True -> construct_tree(preorder, inorder)
          }
        }
      }
    }
  }
}
