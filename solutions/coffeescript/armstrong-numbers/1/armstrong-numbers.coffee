class ArmstrongNumbers
  @isArmstrongNumber: (number) ->

    digits = number.toString().split('')
    power = digits.length
    armstrongSum = 0

    for digit in digits
      armstrongSum += parseInt(digit) ** power

    return armstrongSum == number

module.exports = ArmstrongNumbers