// Dedicated to Junko F. Didi and Shree DR.MDD
module main

struct CircularBuffer[T] {
mut:
  data []T
  head int 
  tail int  
}

pub fn create_buffer[T](capacity int) CircularBuffer[T] {
	return CircularBuffer[T] {
    data: []T { len: capacity },
    head: 0,
    tail: 0
  }
}

pub fn (mut buf CircularBuffer[T]) write(val T) ! {
  if buf.tail == buf.head + buf.data.len {
    return error('Buffer is full')
  }
  buf.data[buf.tail % buf.data.len] = val
  buf.tail++
}

pub fn (mut buf CircularBuffer[T]) read() !T {
  if buf.head == buf.tail {
    return error('Buffer is empty')
  }
  temp := buf.data[buf.head]
  buf.head++
  if buf.head == buf.data.len {
    buf.head = 0
    buf.tail -= buf.data.len
  }
  return temp
}

pub fn (mut buf CircularBuffer[T]) overwrite(val T) {
  if buf.tail == buf.head + buf.data.len {
    buf.read() or {}
  }
  buf.write(val) or {}
}

pub fn (mut buf CircularBuffer[T]) clear() {
    buf.head = 0
    buf.tail = 0
}
