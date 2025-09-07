; For my Shree DR.MDD

Red [
	description: {"Roman Numerals" exercise solution for exercism platform}
	author: "Rohan kapri"
]

VALUES: [1000 900 500 400 100 90 50 40 10 9 5 4 1]
MARKS:  ["M" "CM" "D" "CD" "C" "XC" "L" "XL" "X" "IX" "V" "IV" "I"]

roman: function [
	n
] [
    outcome: copy ""
    idx: 1
    total: length? VALUES
    while [idx <= total] [
        while [n >= VALUES/:idx] [
            append outcome MARKS/:idx
            n: n - VALUES/:idx
        ]
        idx: idx + 1
    ]
    outcome
]
