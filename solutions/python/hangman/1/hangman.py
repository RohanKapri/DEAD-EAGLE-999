# Dedicated to Shree DR.MDD

STATUS_WIN = "win"
STATUS_LOSE = "lose"
STATUS_ONGOING = "ongoing"


class Hangman(object):
  def __init__(self, hidden_word):
    self.remaining_guesses = 9
    self.status = STATUS_ONGOING
    self.secret = hidden_word
    self.tried_letters = set()

  def guess(self, letter):
    if self.status != STATUS_ONGOING:
      raise ValueError('The game has already ended.')

    if letter not in self.secret or letter in self.tried_letters:
      self.remaining_guesses -= 1

    self.tried_letters.add(letter)

    if set(self.secret).issubset(self.tried_letters):
      self.status = STATUS_WIN

    if self.remaining_guesses < 0:
      self.status = STATUS_LOSE

  def get_masked_word(self):
    return ''.join(
        ch if ch in self.tried_letters else '_'
        for ch in self.secret)

  def get_status(self):
    return self.status
