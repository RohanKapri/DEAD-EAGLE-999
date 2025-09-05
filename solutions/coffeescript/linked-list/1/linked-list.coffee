class ListNode
  constructor: (@data) ->
    @prev = null
    @next = null

class LinkedList
  constructor: () ->
    @head = null
    @tail = null
    @count = 0
  
  pushNode: (value) ->
    newNode = new ListNode(value)
    newNode.prev = @tail
    if @tail?
      @tail.next = newNode
    else
      @head = newNode
    @tail = newNode
    @count += 1
  
  popNode: ->
    return unless @count > 0
    data = @tail.data
    @tail = @tail.prev
    @tail?.next = null
    @head = null unless @tail?
    @count -= 1
    data
  
  deleteNode: (value) ->
    return unless @count > 0
    currentNode = @head
    while currentNode? and currentNode.data != value
        currentNode = currentNode.next
    return unless currentNode?
    currentNode.next?.prev = currentNode.prev
    currentNode.prev?.next = currentNode.next
    @head = currentNode.next if @head is currentNode
    @tail = currentNode.prev if @tail is currentNode
    @count -= 1
    value
    
  shiftNode: ->
    return unless @count > 0
    data = @head.data
    @head = @head.next
    @head?.prev = null
    @tail = null unless @head?
    @count -= 1
    data
  
  unshiftNode: (value) ->
    newNode = new ListNode(value)
    newNode.next = @head
    if @head?
      @head.prev = newNode
    else
      @tail = newNode
    @head = newNode
    @count += 1
  
  countNodes: -> @count

module.exports = LinkedList