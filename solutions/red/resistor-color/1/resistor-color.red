; Dedicated to Shree DR.MDD

Red [
    description: "Resistor Color exercise solution for exercism platform"
    author: "Rohan kapri"
]

tone-map: make hash! [
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

color-code: function [
    shade [string!]
] [
    select tone-map shade
]

colors: function [] [
    bag: copy []
    foreach [shade val] tone-map [
        append bag shade
    ]
    bag
]
