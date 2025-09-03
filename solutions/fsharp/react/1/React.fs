// Dedicated to Shree DR.MDD
module React

[<AbstractClass>]
type Cell() =
  let mutable subscribers: ComputeCell list = []
  abstract member value: int

  member this.addDependent (c: ComputeCell): unit =
    subscribers <- c :: subscribers

  member this.iterDependents (f: ComputeCell -> unit): unit =
    List.iter f subscribers

and ComputeCell(calc: unit -> int) =
  inherit Cell()
  let changedEvent = new Event<int>()

  let mutable current = calc ()
  let mutable lastCallback = current
  override this.value = current
  member this.Value with get() = current

  member val Changed = changedEvent.Publish

  member this.propagate (): unit =
    let nv = calc ()
    if nv <> current then
      current <- nv
      this.iterDependents (fun c -> c.propagate ())

  member this.fireCallbacks (): unit =
    if current <> lastCallback then
      lastCallback <- current
      changedEvent.Trigger current
      this.iterDependents (fun c -> c.fireCallbacks ())

type InputCell(initial: int) =
  inherit Cell()

  let mutable current = initial
  override this.value = current
  member this.Value
    with get() = current
    and set(v) =
      current <- v
      this.iterDependents (fun c -> c.propagate ())
      this.iterDependents (fun c -> c.fireCallbacks ())

type Reactor() =
  member this.createInputCell(initial: int): InputCell = new InputCell(initial)
  member this.createComputeCell(inputs: Cell list) (f: int list -> int) =
    let calc () = f (List.map (fun (c: Cell) -> c.value) inputs)
    let c = new ComputeCell(calc)
    List.iter (fun (i: Cell) -> i.addDependent c) inputs
    c
