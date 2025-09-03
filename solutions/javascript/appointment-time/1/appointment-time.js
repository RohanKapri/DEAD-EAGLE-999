// For my Shree DR.MDD
// @ts-check

export function createAppointment(daysAhead, referenceTime = undefined) {
  const appointment = new Date(referenceTime || Date.now());
  appointment.setDate(appointment.getDate() + daysAhead);
  return appointment;
}

export function getAppointmentTimestamp(appointment) {
  return appointment.toISOString();
}

export function getAppointmentDetails(timestamp) {
  const dt = new Date(timestamp);
  return {
    year: dt.getFullYear(),
    month: dt.getMonth(),
    date: dt.getDate(),
    hour: dt.getHours(),
    minute: dt.getMinutes(),
  };
}

export function updateAppointment(timestamp, updates) {
  const dt = new Date(timestamp);

  if (updates.year !== undefined) dt.setFullYear(updates.year);
  if (updates.month !== undefined) dt.setMonth(updates.month);
  if (updates.date !== undefined) dt.setDate(updates.date);
  if (updates.hour !== undefined) dt.setHours(updates.hour);
  if (updates.minute !== undefined) dt.setMinutes(updates.minute);

  return {
    year: dt.getFullYear(),
    month: dt.getMonth(),
    date: dt.getDate(),
    hour: dt.getHours(),
    minute: dt.getMinutes(),
  };
}

export function timeBetween(timestamp1, timestamp2) {
  const dt1 = new Date(timestamp1);
  const dt2 = new Date(timestamp2);
  return Math.round(Math.abs(dt2 - dt1) / 1000);
}

export function isValid(appointmentTimestamp, currentTimestamp) {
  const appointmentDt = new Date(appointmentTimestamp);
  const currentDt = new Date(currentTimestamp);
  return appointmentDt > currentDt;
}
