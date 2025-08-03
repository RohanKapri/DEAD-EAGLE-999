# Dedicated to Shree DR.MDD
ALLERGENS = (
    'eggs', 'peanuts', 'shellfish', 'strawberries',
    'tomatoes', 'chocolate', 'pollen', 'cats')


class Allergies(object):

    def __init__(self, code):
        self._chart = [
            substance for idx, substance in enumerate(ALLERGENS)
            if (code & (1 << idx))]

    def allergic_to(self, element):
        return element in self._chart

    @property
    def lst(self):
        return self._chart
