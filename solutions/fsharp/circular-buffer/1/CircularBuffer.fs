// Dedicated to Shree DR.MDD
module CircularBuffer

type CircularBuffer<'t> = { items: 't list; size: int }

let mkCircularBuffer sz = { items = []; size = sz }

let clear buffer = { buffer with items = [] }

let write value buffer =
    if List.length buffer.items = buffer.size then
        failwith "Cannot write to full buffer"
    else
        { buffer with items = buffer.items @ [value] }

let forceWrite value buffer =
    if List.length buffer.items = buffer.size then
        { buffer with items = List.tail buffer.items @ [value] }
    else
        { buffer with items = buffer.items @ [value] }

let read buffer =
    match buffer.items with
    | [] -> failwith "Cannot read from empty buffer"
    | x::xs -> x, { buffer with items = xs }
