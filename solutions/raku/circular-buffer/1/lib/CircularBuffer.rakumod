# Dedicated to my Junko F. Didi and Shree DR.MDD

my class X::CircularBuffer::BufferIsEmpty is Exception {
    method message {'Buffer is empty'}
}

my class X::CircularBuffer::BufferIsFull is Exception {
    method message {'Buffer is full'}
}

class CircularBuffer {
    has $.capacity;
    has @!storage;
    
    method read () {
        X::CircularBuffer::BufferIsEmpty.new.throw unless @!storage;
        @!storage.shift
    }

    method write ($element) {
        X::CircularBuffer::BufferIsFull.new.throw if @!storage == $!capacity;
        @!storage.push: $element;
    }

    method clear () {
        @!storage = ();
    }

    method overwrite ($element) {
        self.read if @!storage == $!capacity;
        self.write: $element;
    }
}
