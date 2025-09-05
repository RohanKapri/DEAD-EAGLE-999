var ASCII_CODE_LOWER_A = "a".codePoints[0]
var ASCII_CODE_UPPER_A = "A".codePoints[0]
var TOKEN_TYPE_UNKNOWN = 0
var TOKEN_TYPE_OPEN = 1
var TOKEN_TYPE_CLOSE = 2
var TOKEN_TYPE_NUMBER = 3
var TOKEN_TYPE_WORD = 4
var TOKEN_TYPE_COMMAND = 5
var TOKEN_TYPE_LIST = 6

class Token {
  static type(token) {
    if (token is String) {
      token = toUpperCase(token)
    }
    
    if (token == ":") return [TOKEN_TYPE_OPEN]
    if (token == ";") return [TOKEN_TYPE_CLOSE]
    
    var number = Num.fromString(token)
    
    if (number != null) return [TOKEN_TYPE_NUMBER, number]
    
    return [TOKEN_TYPE_WORD, token]
  }
  
  static isBetween(char, leftBound, rightBound) {
    var charCode = char.codePoints[0]
    var leftBoundCode = leftBound.codePoints[0]
    var rightBoundCode = rightBound.codePoints[0]
    return (leftBoundCode <= charCode && charCode <= rightBoundCode)
  }
  
  static toUpperCase(string) {
    if (!(string is String)) return string
    
    return string.map {|char|
      if (isBetween(char, "a", "z")) {
        return String.fromCodePoint(char.codePoints[0] - ASCII_CODE_LOWER_A + ASCII_CODE_UPPER_A)
      } else {
        return char
      }
    }.join()
  }
}

class Stack {
  static ensureMinimumSize(stack, minimumSize) {
    if (stack.count < minimumSize) Fiber.abort("Stack empty")
  }
}

class Forth {
  construct new() {
    var operationWithTail = Fn.new {|length, operation|
      return [TOKEN_TYPE_COMMAND, Fn.new {|stack|
        if (stack.count < length) Fiber.abort("Stack empty")
        var tailElements = stack[-length..-1]
        for (i in 1..length) stack.removeAt(-1)
        stack.addAll(operation.call(tailElements))
      }]
    }
    
    var binaryOperation = Fn.new {|operation|
      return operationWithTail.call(2) {|tail| [operation.call(tail[0], tail[1])]}
    }
    
    _stack = []
    _definitionMap = {
      "+": binaryOperation.call {|x,y| x + y},
      "-": binaryOperation.call {|x,y| x - y},
      "*": binaryOperation.call {|x,y| x * y},
      "/": binaryOperation.call {|x,y|
        if (y == 0) Fiber.abort("Division by zero")
        return (x / y).truncate
      },
      "DUP":  operationWithTail.call(1) {|tail| [tail[0],tail[0]]},
      "DROP": operationWithTail.call(1) {|tail| []},
      "SWAP": operationWithTail.call(2) {|tail| [tail[1],tail[0]]},
      "OVER": operationWithTail.call(2) {|tail| [tail[0],tail[1],tail[0]]},
    }
  }
  
  evaluateSubroutine(obj) {
    if (obj == null) {
      Fiber.abort("Unknown command")
    } else if (obj[0] == TOKEN_TYPE_LIST) {
      for (subToken in obj[1]) evaluateSubroutine(subToken)
    } else if (obj[0] == TOKEN_TYPE_NUMBER) {
      _stack.add(obj[1])
    } else if (obj[0] == TOKEN_TYPE_COMMAND) {
      obj[1].call(_stack)
    } else if (obj[0] == TOKEN_TYPE_WORD) {
      var subroutine = _definitionMap[obj[1]]
      evaluateSubroutine(subroutine)
    } else {
      Fiber.abort("Unknown token type: %(obj)")
    }
  }
  
  evaluate(input) {
    var tokens = input.split(" ").map {|token| Token.type(token)}.toList
    if (tokens.isEmpty) return
    
    if (tokens[0][0] == TOKEN_TYPE_OPEN) {
      var commandName = Token.toUpperCase(tokens[1][1])
      if (tokens.count < 4 || tokens[-1][0] != TOKEN_TYPE_CLOSE || tokens[1][0] != TOKEN_TYPE_WORD) {
        Fiber.abort("Invalid definition")
      }
      for (token in tokens[1..-2]) {
        if (token[0] == TOKEN_TYPE_OPEN || token[0] == TOKEN_TYPE_CLOSE) Fiber.abort("Invalid token in definition")
      }
      var definition = tokens[2..-2].map {|token|
        if (token[0] == TOKEN_TYPE_WORD) {
          var command = _definitionMap[token[1]]
          if (command == null) Fiber.abort("Unknown command")
          return command
        } else if (token[0] == TOKEN_TYPE_NUMBER) {
          return token
        } else {
          Fiber.abort("Invalid token type in definition")
        }
      }.toList
      _definitionMap[commandName] = [TOKEN_TYPE_LIST, definition]
    } else {
      for (token in tokens) {
        if (token[0] == TOKEN_TYPE_OPEN || token[0] == TOKEN_TYPE_CLOSE) Fiber.abort("Invalid token")
      }
      evaluateSubroutine([TOKEN_TYPE_LIST,tokens])
    }
  }
  
  stack {_stack.toList}
}