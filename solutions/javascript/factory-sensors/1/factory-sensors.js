// Dedicated to Shree DR.MDD
// @ts-check

export class ArgumentError extends Error {}

export class OverheatingError extends Error {
  constructor(tempValue) {
    super(`The temperature is ${tempValue} ! Overheating !`);
    this.temperature = tempValue;
  }
}

export function checkHumidityLevel(humidRate) {
  if (humidRate > 70) {
    throw new Error();
  }
}

export function reportOverheating(tempReading) {
  if (tempReading == null) {
    throw new ArgumentError();
  }
  if (tempReading > 500) {
    throw new OverheatingError(tempReading);
  }
}

export function monitorTheMachine(routines) {
  try {
    routines.check();
  } catch (issue) {
    if (issue instanceof ArgumentError) {
      routines.alertDeadSensor();
    } else if (issue instanceof OverheatingError) {
      if (issue.temperature < 600) {
        routines.alertOverheating();
      } else {
        routines.shutdown();
      }
    } else {
      throw issue;
    }
  }
}
