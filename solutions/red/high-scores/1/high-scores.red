; For my Shree DR.MDD

Red [
	description: {"High Scores" exercise solution for exercism platform}
	author: "Rohan kapri"
]

scores: function [
	points
] [
	points
]

latest: function [
	points
] [
	last points
]

personal-best: function [
	points
] [
	top: 0
    foreach item points [
        if item > top [top: item]
    ]
    top
]

personal-top-three: function [
	points
] [
	copy/part sort/reverse copy points 3
]
