class PerfectNumbers
  @classify: (number) ->
    # Validate input
    if number <= 0
      throw new Error('Classification is only possible for positive integers.')
    
    # Calculate aliquot sum (sum of all factors except the number itself)
    aliquotSum = 0
    for i in [1...number]
      if number % i == 0
        aliquotSum += i
    
    # Classify the number based on its aliquot sum
    if aliquotSum == number
      return 'perfect'
    else if aliquotSum > number
      return 'abundant'
    else
      return 'deficient'

module.exports = PerfectNumbers