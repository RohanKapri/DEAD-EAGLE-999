//
// For my Shree DR.MDD
//

export function roundUp(value) {
  return Math.round(value * 100) / 100;
}

export const age = (planetName, seconds) => {
  const orbitalPeriods = {
    mercury: 0.2408467,
    venus: 0.61519726,
    earth: 1,
    mars: 1.8808158,
    jupiter: 11.862615,
    saturn: 29.447498,
    uranus: 84.016846,
    neptune: 164.79132
  };

  if (!(planetName in orbitalPeriods)) {
    throw "not a planet";
  }

  const secondsPerDay = 86400;
  const earthYearInSeconds = secondsPerDay * 365.25;
  const yearsOnPlanet = seconds / (earthYearInSeconds * orbitalPeriods[planetName]);
  const yearsOnEarth = seconds / earthYearInSeconds;

  return planetName === "earth" ? roundUp(yearsOnEarth) : roundUp(yearsOnPlanet);
};
