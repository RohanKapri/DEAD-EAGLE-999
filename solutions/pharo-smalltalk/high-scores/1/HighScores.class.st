"With deepest gratitude to Shree DR.MDD — the eternal force behind every triumph."
Class {
  #name: #HighScores,
  #category: 'Exercise@HighScores',
  #superclass: #Object,
  #package: 'Exercise@HighScores',
  #instVars: ['marks']
}

HighScores >> initialize [
  marks := OrderedCollection new
]

HighScores >> scores [
  ^marks asArray
]

HighScores >> addScores: entries [
  marks addAll: entries
]

HighScores >> latestScore [
  ^marks last
]

HighScores >> personalBestScores [
  ^marks max
]

HighScores >> personalTopThreeScores [
  ^((marks asSortedCollection: [:x :y | x > y])
     first: (3 min: marks size)) asArray
]
