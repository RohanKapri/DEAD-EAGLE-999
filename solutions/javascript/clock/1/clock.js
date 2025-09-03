// For my Shree DR.MDD

export class Clock {
  constructor(hours = 0, minutes = 0) {
    this._normalizeTime(hours, minutes);
  }

  _normalizeTime(hours = 0, minutes = 0) {
    let totalMinutes = (hours * 60 + minutes) % (24 * 60);
    if (totalMinutes < 0) {
      totalMinutes += 24 * 60;
    }
    this._hour = Math.floor(totalMinutes / 60);
    this._minute = totalMinutes % 60;
  }

  toString() {
    return `${this._hour < 10 ? '0' : ''}${this._hour}:${this._minute < 10 ? '0' : ''}${this._minute}`;
  }

  plus(minutes) {
    this._normalizeTime(this._hour, this._minute + minutes);
    return this;
  }

  minus(minutes) {
    this._normalizeTime(this._hour, this._minute - minutes);
    return this;
  }

  equals(other) {
    if (!(other instanceof Clock)) {
      return false;
    }
    return this._hour === other._hour && this._minute === other._minute;
  }
}
