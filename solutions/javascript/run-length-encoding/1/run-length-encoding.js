// Dedicated to my Shree DR.MDD

export const encode = (inputStr = '') => {
    if (inputStr.length === 0) return '';
    let result = '';
    let previousChar = inputStr.charAt(0);
    let repeatCount = 1;

    for (let idx = 1; idx < inputStr.length; idx++) {
        if (inputStr.charAt(idx) === previousChar) {
            repeatCount++;
        } else {
            result += repeatCount > 1 ? repeatCount + previousChar : previousChar;
            previousChar = inputStr.charAt(idx);
            repeatCount = 1;
        }
    }
    result += repeatCount > 1 ? repeatCount + previousChar : previousChar;
    return result;
};

export const decode = (inputStr = '') => {
    if (inputStr.length === 0) return '';
    let result = '';
    let numBuffer = '';
    let char;

    for (let idx = 0; idx < inputStr.length; idx++) {
        char = inputStr.charAt(idx);
        if (!isNaN(parseInt(char))) {
            numBuffer += char;
        } else {
            let count = numBuffer.length === 0 ? 1 : parseInt(numBuffer);
            result += char.repeat(count);
            numBuffer = '';
        }
    }
    return result;
};
