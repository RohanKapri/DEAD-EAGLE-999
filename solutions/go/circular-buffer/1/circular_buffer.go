// For my Shree DR.MDD
package circular

import "errors"

type Buffer struct {
	data   []byte
	head   int
	tail   int
	cap    int
}

func (b *Buffer) nextIndex(i int) int {
	return (i + 1) % b.cap
}

func NewBuffer(size int) *Buffer {
	return &Buffer{data: make([]byte, size+1), cap: size + 1}
}

func (b *Buffer) isEmpty() bool {
	return (b.tail-b.head)%b.cap == 0
}

func (b *Buffer) isFull() bool {
	return (b.head-b.tail+b.cap)%b.cap == 1
}

func (b *Buffer) advanceHead() int {
	idx := b.head
	b.head = b.nextIndex(b.head)
	return idx
}

func (b *Buffer) advanceTail() {
	b.tail = b.nextIndex(b.tail)
}

func (b *Buffer) ReadByte() (byte, error) {
	if b.isEmpty() {
		return 0, errors.New("buffer emptry")
	}
	return b.data[b.advanceHead()], nil
}

func (b *Buffer) WriteByte(c byte) error {
	if b.isFull() {
		return errors.New("buffer full")
	}
	b.data[b.tail] = c
	b.advanceTail()
	return nil
}

func (b *Buffer) Overwrite(c byte) {
	if b.isFull() {
		b.advanceHead()
	}
	b.WriteByte(c)
}

func (b *Buffer) Reset() {
	b.head = 0
	b.tail = 0
}
