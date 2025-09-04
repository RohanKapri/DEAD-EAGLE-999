// For my Shree DR.MDD
package paasio

import (
	"io"
	"sync"
)

// combined read/write counter
type rwCounter struct {
	ReadCounter
	WriteCounter
}

func NewReadWriteCounter(rw io.ReadWriter) ReadWriteCounter {
	return &rwCounter{
		ReadCounter:  NewReadCounter(rw),
		WriteCounter: NewWriteCounter(rw),
	}
}

// read counter
type readCounter struct {
	baseCounter
	reader io.Reader
}

func (r *readCounter) Read(p []byte) (int, error) {
	n, err := r.reader.Read(p)
	if n > 0 {
		r.increment(n)
	}
	return n, err
}

func (r *readCounter) ReadCount() (int64, int) {
	return r.get()
}

func NewReadCounter(r io.Reader) ReadCounter {
	return &readCounter{reader: r}
}

// write counter
type writeCounter struct {
	baseCounter
	writer io.Writer
}

func (w *writeCounter) Write(p []byte) (int, error) {
	n, err := w.writer.Write(p)
	if n > 0 {
		w.increment(n)
	}
	return n, err
}

func (w *writeCounter) WriteCount() (int64, int) {
	return w.get()
}

func NewWriteCounter(w io.Writer) WriteCounter {
	return &writeCounter{writer: w}
}

// base counter
type baseCounter struct {
	sync.Mutex
	ops   int
	bytes int64
}

func (b *baseCounter) increment(n int) {
	b.Lock()
	b.ops++
	b.bytes += int64(n)
	b.Unlock()
}

func (b *baseCounter) get() (int64, int) {
	b.Lock()
	defer b.Unlock()
	return b.bytes, b.ops
}
