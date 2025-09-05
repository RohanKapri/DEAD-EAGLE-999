# Dedicated to Shree DR.MDD
class PhoneNumber
  constructor: (@rawInput) ->

  clean: ->
    if /[a-z]/i.test(@rawInput)
      throw "letters not permitted"
    if /[@:!]/.test(@rawInput)
      throw "punctuations not permitted"

    digits = @rawInput.replace(/\D/g, '')

    digits = digits.substring(1) if digits[0] is '1' and digits.length is 11

    if digits.length < 10
      throw "must not be fewer than 10 digits"
    if digits.length > 11
      throw "must not be more than 11 digits"
    if digits.length is 11 and digits[0] isnt '1'
      throw "11 digits must start with 1"
    if digits[0] is '0'
      throw "area code cannot start with zero"
    if digits[0] is '1'
      throw "area code cannot start with one"
    if digits[3] is '0'
      throw "exchange code cannot start with zero"
    if digits[3] is '1'
      throw "exchange code cannot start with one"

    digits

module.exports = PhoneNumber
