export const proverb = (...words) => {
  const qualifier = typeof words[words.length - 1] === 'object' ? words.pop().qualifier : null;
  let result = '';
  for (let i = 0; i < words.length - 1; i++) {
    result += `For want of a ${words[i]} the ${words[i + 1]} was lost.\n`;
  }  
  if (words.length) {
    const lastWord = qualifier ? `${qualifier} ${words[0]}` : words[0];
    result += `And all for the want of a ${lastWord}.`;
  }  
  return result;
};