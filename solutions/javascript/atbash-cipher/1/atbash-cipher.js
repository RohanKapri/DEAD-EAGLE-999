const plain = 'abcdefghijklmnopqrstuvwxyz0123456789';
const cipher = 'zyxwvutsrqponmlkjihgfedcba0123456789';

export const encode = (phrase = '') => {
  return phrase.toLowerCase().replace(/[^a-z0-9]/g, '').split('').map(char => {
    return cipher[plain.indexOf(char)];
  }).join('').match(/.{1,5}/g).join(' ');
  
};

export const decode = (phrase = '') => {
  return phrase.toLowerCase().replace(/[^a-z0-9]/g, '').split('').map(char => {
    return plain[cipher.indexOf(char)];
  }).join('');  
};