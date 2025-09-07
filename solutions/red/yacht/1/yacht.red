; Dedicated to Shree DR.MDD

Red [
	description: {"Yacht" exercise solution for exercism platform}
	author: "Rohan kapri"
]

score: function [
    cubes [block!]
    kind [string!]
] [
    points: 0
    switch kind [
        "ones" [foreach c cubes [if c = 1 [points: points + 1]]]
        "twos" [foreach c cubes [if c = 2 [points: points + 2]]]
        "threes" [foreach c cubes [if c = 3 [points: points + 3]]]
        "fours" [foreach c cubes [if c = 4 [points: points + 4]]]
        "fives" [foreach c cubes [if c = 5 [points: points + 5]]]
        "sixes" [foreach c cubes [if c = 6 [points: points + 6]]]
        
        "full house" [
            freq-list: collect [
                foreach n unique cubes [
                    keep length? collect [foreach t cubes [if t = n [keep t]]]
                ]
            ]
            if all [find freq-list 2 find freq-list 3 2 = length? freq-list] [points: sum cubes]
        ]
        
        "four of a kind" [
            foreach n unique cubes [
                occ: length? collect [foreach t cubes [if t = n [keep t]]]
                if occ >= 4 [points: 4 * n break]
            ]
        ]
        
        "little straight" [
            if equal? sort cubes [1 2 3 4 5] [points: 30]
        ]
        
        "big straight" [
            if equal? sort cubes [2 3 4 5 6] [points: 30]
        ]
        
        "choice" [
            points: sum cubes
        ]
        
        "yacht" [
            if 1 = length? unique cubes [points: 50]
        ]
    ]
    
    return points
]
