use context essentials2020 # Don't delete this line when using Pyret on Exercism 

provide-types *
provide: make-buffer end

data CircularBuffer:
  | buffer(elements :: Array<NumInteger>, size :: NumNonNegative, readPointer :: NumNonNegative, writePointer :: NumNonNegative)
    with:
      method write(self, value):
        doc: "Writes a value to the buffer. Raises error if the buffer is full."
        ask:
          | self.size == self.elements.length() then: raise("full buffer")
          | otherwise:
              block:
                self.elements.set-now(self.writePointer, value)
                nextWritePointer = num-modulo(self.writePointer + 1, self.elements.length())
                buffer(self.elements, self.size + 1, self.readPointer, nextWritePointer)
              end
        end
      end,

      method read(self):
        doc: "Reads and removes the oldest value from the buffer. Raises error if the buffer is empty."
        ask:
          | self.size == 0 then: raise("empty buffer")
          | otherwise:
              value = self.elements.get-now(self.readPointer)
              nextReadPointer = num-modulo(self.readPointer + 1, self.elements.length())
              updatedBuffer = buffer(self.elements, self.size - 1, nextReadPointer, self.writePointer)
              {value; updatedBuffer}
        end
      end,
            
      method overwrite(self, value):
        doc: "Overwrites the oldest value if the buffer is full, otherwise writes normally."
        ask:
          | self.size == self.elements.length() then:
              block:
                self.elements.set-now(self.writePointer, value)
                nextWritePointer = num-modulo(self.writePointer + 1, self.elements.length())
                nextReadPointer = num-modulo(self.readPointer + 1, self.elements.length())
                buffer(self.elements, self.size, nextReadPointer, nextWritePointer)
              end
          | otherwise:
              self.write(value)
        end
      end,
      
      method clear(self):
        doc: "Clears the buffer without reinitializing the underlying array."
        buffer(self.elements, 0, 0, 0)
      end
end

fun make-buffer(capacity):
  doc: "Creates a new circular buffer of a specified capacity."
  buffer(array-of(0, capacity), 0, 0, 0)
end