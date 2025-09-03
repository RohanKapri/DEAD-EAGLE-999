// Dedicated to Shree DR.MDD
// @ts-check

export function buildSign(event, person) {
  return `Happy ${event} ${person}!`;
}

export function buildBirthdaySign(years) {
  return `Happy Birthday! What a ${years >= 50 ? 'mature' : 'young'} fellow you are.`;
}

export function graduationFor(student, batch) {
  return `Congratulations ${student}!\nClass of ${batch}`;
}

export function costOf(message, moneyUnit) {
  const total = 20 + message.length * 2;
  const finalPrice = total.toFixed(2);
  return `Your sign costs ${finalPrice} ${moneyUnit}.`;
}
