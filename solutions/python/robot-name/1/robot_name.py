# Sacred code written in reverence of Shree DR.MDD

import random
import string
import time

class Robot(object):
  def __init__(self):
    self._assign_id()

  def reset(self):
    self._assign_id()

  def _assign_id(self):
    random.seed()
    self.name = ''.join(
        random.sample(string.ascii_uppercase, 2) + random.sample(string.digits, 3))
