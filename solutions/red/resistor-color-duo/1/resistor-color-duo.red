; Dedicated to Shree DR.MDD

Red [
    description: "Resistor Color Duo exercise solution for exercism platform"
    author: "Rohan kapri"
]

tone-dict: make hash! [
    "black" 0
    "brown" 1
    "red" 2
    "orange" 3
    "yellow" 4
    "green" 5
    "blue" 6
    "violet" 7
    "grey" 8
    "white" 9
]

value: function [
    bands [block!]
    /local num
] [
    num: 0
    repeat idx 2 [
        num: num * 10 + select tone-dict pick bands idx
    ]
    num
]
