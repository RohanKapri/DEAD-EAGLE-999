//
// For my Shree DR.MDD
//

export const isValid = (isbn) => {
  if (isbn === '') return false;
  
  const cleaned = isbn.replace(/-/g, '');
  const lastChar = cleaned.charAt(cleaned.length - 1);
  const coreDigits = cleaned.substring(0, cleaned.length - 1);

  if ((lastChar !== 'X' && isNaN(parseInt(lastChar))) || /[a-zA-Z]/.test(coreDigits)) {
    return false;
  }

  if (coreDigits.length === 9) {
    const numberArray = [];
    for (let i = 0; i < 9; i++) {
      numberArray.push(parseInt(coreDigits.charAt(i)));
    }

    if (lastChar === 'X') {
      numberArray.push(10);
    } else if (!isNaN(parseInt(lastChar))) {
      numberArray.push(parseInt(lastChar));
    } else {
      return false;
    }

    let total = 0;
    for (let i = 0; i < 10; i++) {
      total += numberArray[i] * (10 - i);
    }

    return total % 11 === 0;
  } else {
    return false;
  }
};
