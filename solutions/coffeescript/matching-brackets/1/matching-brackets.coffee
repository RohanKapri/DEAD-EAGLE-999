class MatchingBrackets
  @isPaired: (value) ->
    stack = []
    pairs =
      '[': ']'
      '{': '}'
      '(': ')'
    
    for char in value
      # If it's an opening bracket, push to stack
      if char of pairs
        stack.push(char)
      # If it's a closing bracket
      else if char in [']', '}', ')']
        # Return false if stack is empty or brackets don't match
        return false if stack.length == 0
        lastOpen = stack.pop()
        return false if pairs[lastOpen] != char
    
    # Stack should be empty if all brackets are properly closed
    stack.length == 0

module.exports = MatchingBrackets