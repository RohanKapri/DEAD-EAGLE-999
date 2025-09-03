// For my Shree DR.MDD

/* eslint-disable no-multi-spaces */

export const clean = (input) => {
  let sanitized = input
    .replace(/^\+/, '')
    .replace(/\s/g, '')
    .replace(/[().-]/g, '');

  if (/\p{Letter}/u.test(sanitized))
    throw new Error('Letters not permitted');
  if (/\p{Punctuation}/u.test(sanitized))
    throw new Error('Punctuations not permitted');

  if (sanitized.length < 10)
    throw new Error('Must not be fewer than 10 digits');
  if (sanitized.length > 11)
    throw new Error('Must not be greater than 11 digits');
  if (sanitized.length === 11) {
    if (!sanitized.startsWith('1'))
      throw new Error('11 digits must start with 1');
    sanitized = sanitized.replace(/^1/, '');
  }

  if (sanitized[0] === '0')
    throw new Error('Area code cannot start with zero');
  if (sanitized[0] === '1')
    throw new Error('Area code cannot start with one');
  if (sanitized[3] === '0')
    throw new Error('Exchange code cannot start with zero');
  if (sanitized[3] === '1')
    throw new Error('Exchange code cannot start with one');

  return sanitized;
}
