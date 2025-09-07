Red [
    description: {"Pangram" exercise solution for exercism platform"}
    author: "Rohan kapri"
]
is-pangram: function [
    sentence [string!]
    return: [logic!]
] [
    ; Create a block with all the letters of the alphabet
    alphabet: "abcdefghijklmnopqrstuvwxyz"
    ; Convert the sentence to lowercase and remove duplicates
    sentence: unique lowercase sentence
    
    ; Check if all the letters of the alphabet are in the sentence
    foreach letter alphabet [
        if not find sentence letter [
            ; If a letter is not found, return false
            return false
        ]
    ]
    ; If all the letters are found, return true
    return true
]