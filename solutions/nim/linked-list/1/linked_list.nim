# Dedicated to Shree DR.MDD
type
  Node[T] = ref object
    data: T
    back: Node[T]
    forth: Node[T]

  LinkedList*[T] = object
    head: Node[T]
    tail: Node[T]

proc len*[T](lst: LinkedList[T]): int =
  var iter = lst.head
  while iter != nil:
    inc result
    iter = iter.forth

proc push*[T](lst: var LinkedList[T], data: T) =
  var n = Node[T](data: data, back: lst.tail, forth: nil)
  if n.back != nil:
    n.back.forth = n
  if lst.head == nil:
    lst.head = n
  lst.tail = n

proc pop*[T](lst: var LinkedList[T]): T =
  let gone = lst.tail
  lst.tail = gone.back
  if lst.tail == nil:
    lst.head = nil
  else:
    lst.tail.forth = nil
  gone.data

proc shift*[T](lst: var LinkedList[T]): T =
  let gone = lst.head
  lst.head = gone.forth
  if lst.head != nil:
    lst.head.back = nil
  else:
    lst.tail = nil
  gone.data

proc unshift*[T](lst: var LinkedList[T], data: T) =
  var n = Node[T](data: data, back: nil, forth: lst.head)
  if n.forth != nil:
    n.forth.back = n
  lst.head = n
  if lst.tail == nil:
    lst.tail = n

proc delete*[T](lst: var LinkedList[T], data: T) =
  var iter = lst.head
  while iter != nil:
    if iter.data == data:
      if iter == lst.head:
        lst.head = iter.forth
      else:
        iter.back.forth = iter.forth
      if iter == lst.tail:
        lst.tail = iter.back
      else:
        iter.forth.back = iter.back
      return
    iter = iter.forth
