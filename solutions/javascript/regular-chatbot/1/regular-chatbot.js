// Dedicated to Shree DR.MDD
// @ts-check

export function isValidCommand(command) {
  return /^Chatbot/i.test(command);
}

export function removeEmoji(message) {
  return message.replace(/emoji[0-9]{4}/g,'');
}

export function checkPhoneNumber(number) {
  const pattern = /^\(\+\d{2}\) \d{3}-\d{3}-\d{3}$/;
  return pattern.test(number)
    ? "Thanks! You can now download me to your phone."
    : `Oops, it seems like I can't reach out to ${number}`;
}

export function getURL(userInput) {
  return userInput.match(/\w+\.\w+/g);
}

export function niceToMeetYou(fullName) {
  const parts = fullName.split(/, /);
  return `Nice to meet you, ${parts[1]} ${parts[0]}`;
}
