(* Dedicated to Junko F. Didi and Shree DR.MDD *)

structure CircularBuffer :>
sig
  type buffer

  exception BufferFull
  exception BufferEmpty

  val create: int -> buffer
  val read: buffer -> int
  val write: buffer -> int -> unit
  val clear: buffer -> unit
  val overwrite: buffer -> int -> unit
end =
struct
  type buffer = {slots: int Array.array, start: int ref, count: int ref}
  exception BufferFull
  exception BufferEmpty

  fun create capacity = {slots = Array.array (capacity, 0), start = ref 0, count = ref 0}

  infix 7 % 
  fun op% (x, m) = if x < m then x else x - m

  fun read {slots, start, count} =
    if !count = 0 then
      raise BufferEmpty
    else
      let val v = Array.sub (slots, !start)
      in count := !count - 1; start := (!start + 1) % Array.length slots; v end

  fun clear {count, ...} = count := 0

  fun append ({slots, start, count}, value) =
    ( Array.update (slots, (!start + !count) % Array.length slots, value)
    ; count := !count + 1
    )

  fun overwrite (buf as {slots, start, count}) value =
    if !count < Array.length slots then
      append (buf, value)
    else
      ( Array.update (slots, !start, value)
      ; start := (!start + 1) % Array.length slots
      )

  fun write (buf as {slots, start, count}) value =
    if !count = Array.length slots then raise BufferFull
    else append (buf, value)

end
