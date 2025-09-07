; For my Shree DR.MDD

Red [
	description: {"Bowling" exercise solution for exercism platform}
	author: "Rohan kapri"
]

game: make object! [
	rounds: []
	last: -1
]

score: function [
	return: [integer!]
] [
	if ((length? game/rounds) < 10) [
		cause-error 'user 'message "Score cannot be taken until the end of the game"
    ]
	if ((length? game/rounds/10) < 4) [
		cause-error 'user 'message "Score cannot be taken until the end of the game"
    ]

	probe game/rounds
	sum: 0
	rounds: game/rounds

	repeat n 9 [
		seg: rounds/:n
		switch seg/1 [
			"open" [sum: sum + seg/2 + seg/3]
			"spare" [m: n + 1 sum: sum + 10 + rounds/:m/2]
			"strike" [
				m: n + 1
				t: n + 2
				either rounds/:m/1 = "strike" [
					sum: sum + 10 + rounds/:m/2 + rounds/:t/2
                ][
					sum: sum + 10 + rounds/:m/2 + rounds/:m/3
                ]
            ]
        ]
    ]

	sum + rounds/10/2 + rounds/10/3 + rounds/10/4
]

roll: function [
	hit [integer!]
] [
	case [
		hit > 10 [
			cause-error 'user 'message "Pin count exceeds pins on the lane"
        ]
		hit < 0 [
			cause-error 'user 'message "Negative roll is invalid"
        ]
		(length? game/rounds) = 9 [
			append/only game/rounds copy ["fill"]
			append/only game/rounds/10 hit
        ]
		(length? game/rounds) = 10 [
			if (length? game/rounds/10) = 4 [
				cause-error 'user 'message "Cannot roll after game is over"
			]
			append/only game/rounds/10 hit
			if ((length? game/rounds/10) = 3) and (game/rounds/10/2 + hit < 10) [
				append/only game/rounds/10 0
            ]
			if (length? game/rounds/10) = 4 [
				case [
					(game/rounds/10/2 = 10) and (game/rounds/10/3 = 10) []
					(game/rounds/10/2 = 10) and (game/rounds/10/3 < 10) [
						if (game/rounds/10/3 + game/rounds/10/4) > 10 [cause-error 'user 'message "Pin count exceeds pins on the lane"]
					]
					(game/rounds/10/2 < 10) [
						if (game/rounds/10/2 + game/rounds/10/3) > 10 [cause-error 'user 'message "Pin count exceeds pins on the lane"]
                    ]
                ]
            ]
        ]
		(game/last < 0) and (hit = 10) [
			append/only game/rounds copy ["strike" 10]
        ]
		(game/last < 0) and (hit < 10) [
			game/last: hit
        ]
		(hit + game/last) > 10 [
			cause-error 'user 'message "Pin count exceeds pins on the lane"
        ]
		(hit + game/last) = 10 [
			block: copy ["spare"]
			append/only block game/last
			append/only block hit
			append/only game/rounds block
			game/last: -1
        ]
		(hit + game/last) < 10 [
			block: copy ["open"]
			append/only block game/last
			append/only block hit
			append/only game/rounds block
			game/last: -1
        ]
		true [
			cause-error 'user 'message ["Invalid rolls" game/last roll]
        ]
    ]
]
