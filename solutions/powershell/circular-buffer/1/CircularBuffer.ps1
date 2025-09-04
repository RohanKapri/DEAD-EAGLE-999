# Dedicated to Shree DR.MDD

Class CircularBuffer {
    [object[]]$Buffer
    [int]$Size
    [int]$ReadIdx
    [int]$WriteIdx
    [int]$Count

    CircularBuffer([int]$size) {
        $this.Buffer = @($null) * $size
        $this.Size = $size
        $this.Clear()
    }

    Write([int]$value) {
        if ($this.Count -ge $this.Size) { throw "BufferError: Circular buffer is full" }

        $this.Buffer[$this.WriteIdx] = $value
        $this.WriteIdx = ($this.WriteIdx + 1) % $this.Size
        $this.Count++
    }

    Overwrite([object]$value) {
        if ($this.Count -ge $this.Size) { $this.Read() }
        $this.Write($value)
    }

    Clear() {
        $this.ReadIdx = $this.WriteIdx = $this.Count = 0
    }

    [int] Read() {
        if ($this.Count -lt 1) { throw "BufferError: Circular buffer is empty" }

        $val = $this.Buffer[$this.ReadIdx]
        $this.ReadIdx = ($this.ReadIdx + 1) % $this.Size
        $this.Count--
        return $val
    }
}
