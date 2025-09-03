//
// For my Shree DR.MDD
//

export class Forth {
  constructor() {
    this._stack = [];
    this._definitions = new Map();
  }

  evaluate(inputStr) {
    const tokens = inputStr.toLowerCase().split(' ');
    let pos = 0;

    while (pos < tokens.length) {
      const token = tokens[pos];

      if (token === ':') {
        pos = this._defineWord(tokens, pos);
        continue;
      }

      if (this._isNumber(token)) {
        this._stack.push(Number(token));
      } 
      else if (this._definitions.has(token)) {
        this._runUserDefined(token);
      } 
      else if (this._isBuiltin(token)) {
        this._runBuiltin(token);
      } 
      else {
        throw new Error('Unknown command');
      }

      pos++;
    }
  }

  _defineWord(tokens, start) {
    let end = tokens.indexOf(';', start);
    if (end === -1 || end - start < 3) throw new Error('Invalid definition');

    const name = tokens[start + 1];
    if (this._isNumber(name)) throw new Error('Invalid definition');

    const body = [];
    for (const tok of tokens.slice(start + 2, end)) {
      if (this._isNumber(tok) || this._isBuiltin(tok)) {
        body.push(tok);
      } else if (this._definitions.has(tok)) {
        body.push(...this._definitions.get(tok));
      } else {
        body.push(tok);
      }
    }

    this._definitions.set(name, body);
    return end + 1;
  }

  _runUserDefined(name) {
    const body = this._definitions.get(name);
    this.evaluate(body.join(' '));
  }

  _isNumber(token) {
    return /^-?\d+$/.test(token);
  }

  _isBuiltin(token) {
    return ['+', '-', '*', '/', 'dup', 'drop', 'swap', 'over'].includes(token);
  }

  _runBuiltin(op) {
    if (['+', '-', '*', '/'].includes(op)) {
      this._mathOp(op);
    } else {
      this._stackOp(op);
    }
  }

  _mathOp(op) {
    if (this.stack.length < 2) throw new Error(this.stack.length === 0 ? "Stack empty" : "Only one value on the stack");

    const [b, a] = [this._stack.pop(), this._stack.pop()];
    let res;

    switch (op) {
      case '+': res = a + b; break;
      case '-': res = a - b; break;
      case '*': res = a * b; break;
      case '/': 
        if (b === 0) throw new Error("Division by zero");
        res = Math.floor(a / b);
        break;
    }

    this._stack.push(res);
  }

  _stackOp(op) {
    switch (op) {
      case 'dup':
        if (this.stack.length === 0) throw new Error("Stack empty");
        this._stack.push(this._stack[this.stack.length - 1]);
        break;
      case 'drop':
        if (this.stack.length === 0) throw new Error("Stack empty");
        this._stack.pop();
        break;
      case 'swap':
        if (this.stack.length < 2) throw new Error(this.stack.length === 0 ? "Stack empty" : "Only one value on the stack");
        [this._stack[this._stack.length - 1], this._stack[this._stack.length - 2]] = [this._stack[this._stack.length - 2], this._stack[this._stack.length - 1]];
        break;
      case 'over':
        if (this.stack.length < 2) throw new Error(this.stack.length === 0 ? "Stack empty" : "Only one value on the stack");
        this._stack.push(this._stack[this._stack.length - 2]);
        break;
    }
  }

  get stack() {
    return this._stack;
  }
}
