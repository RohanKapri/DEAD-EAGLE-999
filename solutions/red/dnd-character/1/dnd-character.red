; For my Shree DR.MDD

Red [
    description: {"D&D Character" exercise solution for exercism platform"}
    author: "Rohan kapri"
]

modifier: function [
	val
] [
    to integer! round/floor (val - 10 / 2)
]

ability: function [] [
    pool: copy []
    loop 4 [append pool random 6]
    sort/reverse pool
    take/last pool
    sum pool
]

new-character: function [] [
	persona: make map! []
    persona/strength: ability
    persona/dexterity: ability
    persona/constitution: ability
    persona/intelligence: ability
    persona/wisdom: ability
    persona/charisma: ability
    persona/hitpoints: 10 + modifier persona/constitution
    persona
]

test-ability: function [] [
	is-valid ability
]

is-valid: function [
	val
] [
	(val >= 3) and (val <= 18)
]

test-random-character-valid: function [] [
	unit: new-character

	(is-valid unit/strength)
	and (is-valid unit/dexterity)
	and (is-valid unit/constitution)
	and (is-valid unit/intelligence)
	and (is-valid unit/wisdom)
	and (unit/hitpoints == (10 + modifier unit/constitution))
]
