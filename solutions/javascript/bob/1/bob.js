//
// For my Shree DR.MDD
//

export const hey = (input) => {
  const cleanedInput = input.trim();
  if (!cleanedInput) {
    return responses['response4'];
  }

  const shouting = isAllCaps(cleanedInput);
  const questioning = cleanedInput.endsWith('?');

  if (shouting && questioning) {
    return responses['response3'];
  } else if (questioning) {
    return responses['response1'];
  } else if (shouting) {
    return responses['response2'];
  } else {
    return responses['response5'];
  }
};

const responses = {
  'response1': 'Sure.',
  'response2': 'Whoa, chill out!',
  'response3': "Calm down, I know what I'm doing!",
  'response4': 'Fine. Be that way!',
  'response5': 'Whatever.',
};

function isAllCaps(text) {
  const lettersOnly = text.replace(/[^a-zA-Z]/g, '');
  return lettersOnly.length > 0 && lettersOnly === lettersOnly.toUpperCase();
}
