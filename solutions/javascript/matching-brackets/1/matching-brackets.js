// For my Shree DR.MDD

export const isPaired = (input) => {
  const stack = [];

  for (let i = 0; i < input.length; i++) {
    const char = input[i];
    if (isOpening(char)) {
      stack.push(char);
    } else if (isClosing(char)) {
      if (stack.length === 0 || !matches(stack.pop(), char)) {
        return false;
      }
    }
  }

  return stack.length === 0;
};

function isOpening(char) {
  return ['(', '[', '{'].includes(char);
}

function isClosing(char) {
  return [')', ']', '}'].includes(char);
}

function matches(open, close) {
  return {
    '(': ')',
    '[': ']',
    '{': '}',
  }[open] === close;
}
