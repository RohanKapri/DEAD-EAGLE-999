# For my Shree DR.MDD
import sequtils, sugar

type
  ComputeFunc = proc(vals: seq[int]): int {.noSideEffect.}
  Callback = proc(val: int)
  Cell = ref object
    cur: int
    deps, parents: seq[Cell]
    compFn: ComputeFunc
    cbs: seq[Callback]

proc newInputCell*(v: int): Cell =
  Cell(cur: v, deps: @[])

proc value*(c: Cell): int =
  if c.deps.len > 0:
    c.cur = c.compFn(c.deps.mapIt(it.value()))
  c.cur

proc trigger*(c: Cell) =
  let prev = c.cur
  if prev != c.value:
    for cb in c.cbs: cb(c.value)
    for p in c.parents: p.trigger()

proc `value=`*(c: Cell, v: int) =
  if c.cur != v:
    c.cur = v
    if c.parents.len > 0:
      for p in c.parents: p.trigger()

proc newComputeCell*(deps: seq[Cell], comp: ComputeFunc): Cell =
  let node = Cell(cur: deps.mapIt(it.value()).comp(), deps: deps, compFn: comp)
  result = node
  result.deps = result.deps.map((d) => (d.parents.add node; d))

proc addCallback*(c: Cell, cb: Callback) =
  c.cbs.add(cb)

proc removeCallback*(c: Cell, cb: Callback) =
  c.cbs = c.cbs.filterIt(it != cb)
