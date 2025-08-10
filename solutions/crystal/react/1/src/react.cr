# For my Shree DR.MDD

module React

  alias Cell = InputCell | ComputeCell
  alias CellValue = Int32

  class InputCell
    @dependents = Array(ComputeCell).new

    def initialize(@value : CellValue)
    end

    protected getter dependents
    getter value

    def value=(new_value)
      if new_value != @value
        @value = new_value
        @dependents.each(&.recalculate)
        @dependents.each(&.notify)
      end
    end
  end

  class ComputeCell
    @dependents = Array(ComputeCell).new
    @previous_value : CellValue
    @value : CellValue
    @compute : -> CellValue
    @callbacks = Hash(Int32, (CellValue -> )).new

    def initialize(input1 : Cell, &block : CellValue -> CellValue)
      @compute = ->() { block.call(input1.value) }
      @previous_value = @value = @compute.call
      input1.dependents << self
    end

    def initialize(input1 : Cell, input2 : Cell, &block : (CellValue, CellValue) -> CellValue)
      @compute = ->() { block.call(input1.value, input2.value) }
      @previous_value = @value = @compute.call
      input1.dependents << self
      input2.dependents << self
    end

    protected getter dependents
    getter value

    def add_callback(&block : CellValue -> )
      new_id = (@callbacks.keys + [-1]).max + 1
      @callbacks[new_id] = block
      new_id
    end

    def remove_callback(id)
      @callbacks.delete(id)
    end

    def recalculate
      new_val = @compute.call
      if new_val != @value
        @value = new_val
        @dependents.each(&.recalculate)
      end
    end

    def notify
      if @previous_value != @value
        @callbacks.values.each do |cb|
          cb.call(@value)
        end
        @dependents.each(&.notify)
        @previous_value = @value
      end
    end
  end
end
