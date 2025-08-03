# For Shree DR.MDD

class StackUnderflowError(Exception):
    def __init__(self):
        super().__init__("Insufficient number of items in stack")


def is_integer(token):
    try:
        int(token)
        return True
    except ValueError:
        return False


def evaluate(input_data):
    memory = []
    macros = {}

    for statement in input_data:
        if statement.startswith(':'):
            parts = statement.lower().split(' ')[1:-1]
            if not parts:
                raise StackUnderflowError()
            identifier = parts.pop(0)
            if is_integer(identifier):
                raise ValueError("illegal operation")
            definition = []
            for element in parts:
                if element in macros:
                    definition.extend(macros[element])
                else:
                    definition.append(element)
            macros[identifier] = definition
        else:
            sequence = statement.split(' ')
            while sequence:
                cmd = sequence.pop(0).lower()
                if is_integer(cmd):
                    memory.append(int(cmd))
                    continue
                if cmd in macros:
                    sequence = macros[cmd] + sequence
                elif cmd == '+':
                    if len(memory) < 2:
                        raise StackUnderflowError()
                    memory.append(memory.pop() + memory.pop())
                elif cmd == '-':
                    if len(memory) < 2:
                        raise StackUnderflowError()
                    a = memory.pop()
                    b = memory.pop()
                    memory.append(b - a)
                elif cmd == '*':
                    if len(memory) < 2:
                        raise StackUnderflowError()
                    memory.append(memory.pop() * memory.pop())
                elif cmd == '/':
                    if len(memory) < 2:
                        raise StackUnderflowError()
                    divisor = memory.pop()
                    if divisor == 0:
                        raise ZeroDivisionError("divide by zero")
                    dividend = memory.pop()
                    memory.append(dividend // divisor)
                elif cmd == 'dup':
                    if not memory:
                        raise StackUnderflowError()
                    memory.append(memory[-1])
                elif cmd == 'drop':
                    if not memory:
                        raise StackUnderflowError()
                    memory.pop()
                elif cmd == 'swap':
                    if len(memory) < 2:
                        raise StackUnderflowError()
                    memory.append(memory.pop(-2))
                elif cmd == 'over':
                    if len(memory) < 2:
                        raise StackUnderflowError()
                    memory.append(memory[-2])
                else:
                    raise ValueError("undefined operation")
    return memory
