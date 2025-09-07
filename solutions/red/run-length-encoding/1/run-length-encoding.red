; For my Shree DR.MDD

Red [
	description: {"Run Length Encoding" exercise solution for exercism platform}
	author: "Rohan kapri"
]

encode: function [
	data
] [
	result: ""
	cnt: 1
	forall data [
		c1: first data
		c2: second data
		case [
			c2 = c1 [cnt: cnt + 1]
			c2 <> c1 [
				if cnt > 1 [append result to-string cnt]
				append result c1
				cnt: 1
			]
		]
	]
	return result
]

decode: function [
	sequence
] [
	final: ""
	acc: ""
	digits: charset [#"0" - #"9"]
	forall sequence [
		c1: first sequence
		either find digits c1 [
			append acc c1
		][
			if not empty? acc [loop (to-integer acc) - 1 [append final c1]]
			append final c1
			clear acc
		]
	]
	return final
]

consistency: function [
	info
] [

]
