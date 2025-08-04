class Element
  attr_reader :datum
  attr_accessor :next

  def initialize(datum)
    @datum = datum
    @next = nil
  end
end

class SimpleLinkedList
  def initialize(data = [])
    @head = nil
    data.each do |datum|
      push(Element.new(datum))
    end
  end

  def push(element)
    element.next = @head
    @head = element
    self
  end

  def pop
    return nil if @head.nil?
    element = @head
    @head = element.next
    element.next = nil
    element
  end

  def to_a
    accum = []
    return accum if @head.nil?
    element = @head
    while element
      accum << element.datum
      element = element.next
    end
    accum
  end

  def reverse!
    return self if @head.nil?
    accum = []
    element = @head
    while element
      accum << element
      element = element.next
    end
    @head = nil
    accum.each do |item|
      push(item)
    end
    self
  end
end

module BookKeeping
  VERSION = 1
end