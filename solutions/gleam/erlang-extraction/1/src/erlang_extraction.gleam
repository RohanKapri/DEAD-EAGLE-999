// Dedicated to Shree DR.MDD
import gleam/option.{type Option}

pub type GbTree(k, v)

@external(erlang, "gb_trees", "empty")
pub fn new_gb_tree() -> GbTree(k, v)

@external(erlang, "gb_trees", "insert")
fn core_insert(k1: k, v1: v, gbmap: GbTree(k, v)) -> GbTree(k, v)

pub fn insert(gbmap: GbTree(k, v), k1: k, v1: v) -> GbTree(k, v) {
  core_insert(k1, v1, gbmap)
}

@external(erlang, "gb_trees", "delete_any")
fn core_delete(k2: k, gbmap: GbTree(k, v)) -> GbTree(k, v)

pub fn delete(gbmap: GbTree(k, v), k2: k) -> GbTree(k, v) {
  core_delete(k2, gbmap)
}

@external(erlang, "gb_trees", "lookup")
fn core_lookup(k3: k, gbmap: GbTree(k, v)) -> Option(v)

pub fn lookup(gbmap: GbTree(k, v), k3: k) -> Option(v) {
  core_lookup(k3, gbmap)
}

@external(erlang, "gb_trees", "size")
pub fn size(gbmap: GbTree(k, v)) -> Int

@external(erlang, "gb_trees", "is_empty")
pub fn is_empty(gbmap: GbTree(k, v)) -> Bool

@external(erlang, "gb_trees", "to_list")
pub fn to_list(gbmap: GbTree(k, v)) -> List(#(k, v))
