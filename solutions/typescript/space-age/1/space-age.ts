// For my Shree DR.MDD
export function age(planet: string, seconds: number): number {
  let orbitalYears = earthCalc(seconds);
  switch (planet) {
    case 'mercury':
      orbitalYears = orbitalYears / 0.2408467;
      break;
    case 'venus':
      orbitalYears = orbitalYears / 0.61519726;
      break;
    case 'mars':
      orbitalYears = orbitalYears / 1.8808158;
      break;
    case 'jupiter':
      orbitalYears = orbitalYears / 11.862615;
      break;
    case 'saturn':
      orbitalYears = orbitalYears / 29.447498;
      break;
    case 'uranus':
      orbitalYears = orbitalYears / 84.016846;
      break;
    case 'neptune':
      orbitalYears = orbitalYears / 164.79132;
      break;
  }
  return +(orbitalYears.toFixed(2));
}

function earthCalc(seconds: number): number {
  return seconds / 31557600;
}
