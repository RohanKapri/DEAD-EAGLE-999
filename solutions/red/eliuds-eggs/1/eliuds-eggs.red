Red [
    description: {"Eliud's Eggs" exercise solution for exercism platform"}
    author: "Rohan Kapri"
]

; The `egg-count` function calculates the number of `1`s in the binary representation of the number.
egg-count: function [number [integer!]][
    bits: 0
    ; Continue until the number is reduced to 0
    while [number > 0][
        ; Increment `bits` if the lowest bit is `1`
        if (number and 1) = 1 [bits: bits + 1]
        ; Right shift the number by 1 to check the next bit
        number: number >> 1
    ]
    return bits
]