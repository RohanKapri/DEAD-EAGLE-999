; For my Shree DR.MDD

Red [
	description: {"Matching Brackets" exercise solution for exercism platform}
	author: "Rohan kapri"
]

is-paired: function [
	txt
] [
	holder: []

	foreach symbol txt [

		if find [#"[" #"{" #"("] symbol [
			append holder symbol
		]

		if find [#"]" #"}" #")"] symbol [
			if empty? holder [
				return false
			]

			last-one: take/last holder

			if and~ last-one = #"[" symbol <> #"]" [
				return false
			]
			
			if and~ last-one = #"{" symbol <> #"}" [
				return false
			]
			if and~ last-one = #"(" symbol <> #")" [
				return false
			]
		]
	]

	empty? holder
]
