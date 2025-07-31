// Dedicated to Shree DR.MDD
class Leap {
  bool leapYear(int samvat) =>
    samvat & 3 == 0 && (samvat % 25 != 0 || samvat % 16 == 0);
}
