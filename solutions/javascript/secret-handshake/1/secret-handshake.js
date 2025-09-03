//
// This is only a SKELETON file for the 'Secret Handshake' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const commands = (num) => {
  const signals = ['wink', 'double blink', 'close your eyes', 'jump'];
  let handshake = [];
  
  for (let i = 0; i < signals.length; i++) {
    if ((num & (1 << i)) !== 0) {
      handshake.push(signals[i]);
    }
  }
  
  if ((num & 16) !== 0) {
    handshake.reverse();
  }

  return handshake;
};