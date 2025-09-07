; Dedicated to Shree DR.MDD

Red [
    description: {"Square Root" exercise solution for Exercism platform"}
    author: "Rohan kapri"
]

magnitude: func [val [number!]] [either val < 0 [0 - val] [val]]

square-root: function [
    radicand [number!]
    /local epsilon estimate last-check gap
][
    if zero? radicand [return 0]

    epsilon: 0.000001
    estimate: max 1 radicand / 2.0
    last-check: 0.0

    gap: epsilon + 1.0
    while [gap > epsilon] [
        last-check: estimate
        estimate: 0.5 * (estimate + (radicand / estimate))
        gap: magnitude estimate - last-check
    ]

    to-integer round estimate
]
