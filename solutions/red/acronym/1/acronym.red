Red [
    description: {"Acronym" exercise solution for Exercism platform"}
    author: "Rohan Kapri"
]

abbreviate: function [
    phrase [string!]
    return: [string!]
] [
    words-in-phrase: split phrase charset " -_"
    return rejoin collect [
        foreach word words-in-phrase [
            if none <> first word [keep uppercase first word]
        ]
    ]
]