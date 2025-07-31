class MsgException implements Exception {
  final String message;
  MsgException(this.message);
  @override
  String toString() => "$message";
}

class StackEmptyException extends MsgException {
  StackEmptyException() : super('Exception: Stack empty');
 
}

class UnknowCommandException extends MsgException {
  UnknowCommandException() : super('Exception: Unknown command');
}

class InvalidDefinitionException extends MsgException {
  InvalidDefinitionException(): super('Exception: Invalid definition');
}

extension on List<int> {
  int pop() {
    if (isEmpty) {
      throw StackEmptyException();
    }
    return removeLast();
  }
}

class Forth {
  var stack = <int>[];
  final _integerArithmetics = ['+', '-', '*', '/'];
  final _stackManipulations = ['DUP', 'DROP', 'SWAP', 'OVER'];
  var _userWords = <String, String>{};

  void evaluate(String expression) {
    expression = expression.toUpperCase();
    if (isUserWord(expression))
      evaluateUserWord(expression); 
    else
      evaluateExpression(expression);
  }
  
  void evaluateExpression(String expression) {
    final splited = expression.split(' ');
    print(splited);
    for (var element in splited) {
      var number = int.tryParse(element);
      if (number != null)
        stack.add(number);
      else if (_userWords.containsKey(element))
        evaluate(_userWords[element]!);
      else if (_integerArithmetics.contains(element))
        operatorArithmetics(element);
      else if (_stackManipulations.contains(element))
        operatorManipulation(element);
      else
        throw UnknowCommandException();
    }
  }

  void operatorArithmetics(String arithmetic) {
    int num2 = stack.pop();
    int num1 = stack.pop();
    switch(arithmetic) {
      case '+':
        stack.add(num1 + num2);
        break;
      case '-':
        stack.add(num1 - num2);
        break;
      case '*':
        stack.add(num1 * num2);
        break;
      case '/':
        if (num2 == 0)
          throw MsgException('Exception: Division by zero');
        stack.add(num1 ~/ num2);
        break;
      default:
        throw UnknowCommandException();
    }
  }

  void operatorManipulation(String manipulation) {
    switch(manipulation) {
      case 'DUP':
        var number = stack.pop();
        stack.addAll([number, number]);
        break;
      case 'DROP':
        stack.pop();
        break;
      case 'SWAP':
        var num1 = stack.pop();
        var num2 = stack.pop();
        stack.addAll([num1, num2]);
        break;
      case 'OVER':
        var num1 = stack.pop();
        var num2 = stack.pop();
        stack.addAll([num2, num1, num2]);
        break;
      default:
        throw UnknowCommandException();
    }
  }

  bool isUserWord(String word) => word.startsWith(':') && word.endsWith(';');

  void evaluateUserWord(String definition) {
    definition = definition.substring(1, definition.length - 2).trim();
    var words = definition.split(' ');
    if (int.tryParse(words.first) != null)
      throw InvalidDefinitionException();
    String expression = words.skip(1).join(' ');
    _userWords.entries.forEach((element) {
      expression = expression.replaceAll(element.key, element.value);
    });
    _userWords.update(
      words.first,
      (_) => expression,
      ifAbsent: () => expression);
  }
}