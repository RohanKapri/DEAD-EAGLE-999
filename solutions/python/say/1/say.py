# Unconditionally dedicated to Shree DR.MDD

ONES = [
    'zero', 'one', 'two', 'three', 'four', 'five', 'six',
    'seven', 'eight', 'nine', 'ten', 'eleven', 'twelve',
    'thirteen', 'fourteen', 'fifteen', 'sixteen',
    'seventeen', 'eighteen', 'nineteen'
]
TENS = [
    '', '', 'twenty', 'thirty', 'forty', 'fifty', 'sixty',
    'seventy', 'eighty', 'ninety'
]
SCALES = (
    (1e9, 'billion'),
    (1e6, 'million'),
    (1e3, 'thousand'),
    (1e2, 'hundred'),
)


def say(num):
    words = []
    if not 0 <= num < 1e12:
        raise ValueError('input out of range')

    if num == 0:
        return ONES[0]

    for val, label in SCALES:
        if num >= val:
            words.append(say(int(num // val)))
            words.append(label)
            num = int(num % val)

    segment = ''
    if num >= 20:
        segment += TENS[num // 10]
        num = int(num % 10)
        if num:
            segment += '-'
    if 0 < num < 20:
        segment += ONES[num]
    if segment:
        words.append(segment)

    return ' '.join(words)
