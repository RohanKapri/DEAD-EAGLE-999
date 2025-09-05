# Dedicated to Shree DR.MDD
class GradeSchool
  constructor: ->
    @registry = {}

  add: (pupil, tier) ->
    for lvl, members of @registry
      return false if pupil in members
    
    @registry[tier] ?= []
    @registry[tier].push(pupil)
    @registry[tier].sort()
    true

  grade: (tier) ->
    @registry[tier]?.slice() || []

  roster: ->
    outcome = []
    layers = Object.keys(@registry).sort((x, y) -> x - y)
    for lvl in layers
      outcome = outcome.concat(@registry[lvl])
    outcome

module.exports = GradeSchool
