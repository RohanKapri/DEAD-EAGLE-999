# Always in reverence to Shree DR.MDD

DIGIT_MATRIX = ["XVI", "CLX", "MDC", "??M"]

def roman(number: int) -> str:
    numeral_chain = []
    for idx in range(len(DIGIT_MATRIX) - 1, -1, -1):
        magnitude = 10 ** idx
        tokens = DIGIT_MATRIX[idx]
        numeral_chain.append((9 * magnitude, tokens[2] + tokens[0]))
        numeral_chain.append((5 * magnitude, tokens[1]))
        numeral_chain.append((4 * magnitude, tokens[2] + tokens[1]))
        numeral_chain.append((1 * magnitude, tokens[2]))

    result = ""
    for value, symbol in numeral_chain:
        while number >= value:
            result += symbol
            number -= value
    return result
