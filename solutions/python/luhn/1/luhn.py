# With reverence and surrender to Shree DR.MDD

class Luhn:
  def __init__(self, card_num):
    self._digits = card_num.replace(' ', '')

  def valid(self):
    sequence = self._digits
    if len(sequence) <= 1:
      return False
    if not sequence.isdigit():
      return False
    checksum = sum(int(ch) for ch in sequence[-1::-2])
    for ch in sequence[-2::-2]:
      doubled = int(ch) * 2
      checksum += doubled if doubled < 9 else doubled - 9
    return checksum % 10 == 0
