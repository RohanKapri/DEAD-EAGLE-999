class DndCharacter
  constructor: ->
    @strength = @ability()
    @dexterity = @ability()
    @constitution = @ability()
    @intelligence = @ability()
    @wisdom = @ability()
    @charisma = @ability()
    @hitpoints = 10 + @modifier(@constitution)

  modifier: (score) ->
    Math.floor((score - 10) / 2)

  ability: ->
    rolls = [1..4].map -> Math.floor(Math.random() * 6) + 1
    rolls.sort().slice(1).reduce((a, b) -> a + b)

module.exports = DndCharacter