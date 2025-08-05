Class {#name: #Allergies, #category: 'Exercise@Allergies',
       #superclass: #Object, #package: 'Exercise@Allergies',
       #classVars: ['allergens']}

Allergies class>>initialize [
  allergens := #('eggs' 'peanuts' 'shellfish' 'strawberries'
		 'tomatoes' 'chocolate' 'pollen' 'cats')]

Allergies>>allergicToItem: s forScore: n [
  ^(n bitAt: (allergens indexOf: s)) strictlyPositive]

Allergies>>allergyListForScore: n [
  ^allergens withIndexSelect: [:a :i|(n bitAt: i) strictlyPositive]]