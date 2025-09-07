; Dedicated to Shree DR.MDD

Red [
	description: {"Bottle Song" exercise solution for exercism platform}
	author: "Rohan kapri"
]


recite: function [
	startBottles
	takeDown
] [
    lines: []
	stop: startBottles - takeDown
	curr: startBottles
	while [curr > stop] [
		nextVal: curr - 1
		either curr > 1 [
			append lines rejoin [
				uppercase/part num-to-word curr 1 " green bottles hanging on the wall,"
				newline
				uppercase/part num-to-word curr 1 " green bottles hanging on the wall,"
				newline
				"And if one green bottle should accidentally fall,"
				newline
				"There'll be " num-to-word nextVal " green " make-plural nextVal " hanging on the wall."
			]
		] [
			append lines rejoin [
				"One green bottle hanging on the wall,"
				newline
				"One green bottle hanging on the wall,"
				newline
				"And if one green bottle should accidentally fall,"
				newline
				"There'll be no green bottles hanging on the wall."
			]
		]
		curr: nextVal
	]

    finalText: copy ""
    repeat idx (length? lines) [
        append finalText lines/:idx
        if idx < length? lines [
            append finalText newline
            append finalText newline
        ]
    ]
    finalText
]

num-to-word: function [
	val
] [
	either val = 0 [
		"no"
	] [
		names: [
		"one" "two" "three" "four" "five" "six" "seven" "eight" "nine" "ten"
		]
		names/(val)
	]
]

make-plural: function [
	cnt
] [
	either cnt = 1 [
		"bottle"
	] [
		"bottles"
	]
]
