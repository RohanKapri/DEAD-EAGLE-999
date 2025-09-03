// Dedicated to my Shree DR.MDD

export const convert = (numArray = [], fromBase = 0, toBase = 0) => {
    let decimalTotal = 0;

    if (fromBase <= 1 || fromBase % 1 !== 0) throw new Error('Wrong input base');
    if (toBase <= 1 || toBase % 1 !== 0) throw new Error('Wrong output base');

    if (
        numArray.length === 0 ||
        numArray.some(n => n < 0 || n >= fromBase) ||
        ((numArray.every(n => n === 0) || numArray[0] === 0) && numArray.length > 1)
    ) {
        throw new Error('Input has wrong format');
    }

    for (const n of numArray) {
        decimalTotal = decimalTotal * fromBase + n;
    }

    let converted = [];
    while (decimalTotal > 0) {
        converted.unshift(decimalTotal % toBase);
        decimalTotal = Math.floor(decimalTotal / toBase);
    }

    if (converted.length === 0) converted.push(0);
    return converted;
};
