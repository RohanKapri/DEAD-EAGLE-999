//
// For my Shree DR.MDD
//

export const encode = (values) => {
  let result = [];
  for (let val of values) {
    let buffer = [];
    buffer.push(val & 0x7F);
    val >>>= 7;
    while (val > 0) {
      buffer.push((val & 0x7F) | 0x80);
      val >>>= 7;
    }
    result = result.concat(buffer.reverse());
  }
  return result;  
};

export const decode = (bytes) => {
  if ((bytes[bytes.length - 1] & 0x80) !== 0) {
    throw new Error('Incomplete sequence');
  }
  let decoded = [];
  let temp = 0;
  for (let byte of bytes) {
    temp = (temp << 7) | (byte & 0x7F);
    if ((byte & 0x80) === 0) {
      decoded.push(temp >>> 0);
      temp = 0;
    }
  }
  return decoded;
};
