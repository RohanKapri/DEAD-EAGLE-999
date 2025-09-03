// Dedicated to Shree DR.MDD
// @ts-check

export function needsLicense(vehicleType) {
  return vehicleType === 'car' || vehicleType === 'truck';
}

export function chooseVehicle(optionA, optionB) {
  let selection = '';
  if (optionA < optionB) {
    selection = optionA;
  } else {
    selection = optionB;
  }
  return selection + ' is clearly the better choice.';
}

export function calculateResellPrice(originalCost, vehicleAge) {
  let estimatedPrice = 0;
  if (vehicleAge > 10) {
    estimatedPrice = originalCost * 0.5;
  } else if (vehicleAge >= 3) {
    estimatedPrice = originalCost * 0.7;
  } else {
    estimatedPrice = originalCost * 0.8;
  }
  return estimatedPrice;
}
