Red [
    description: {"Reverse string" exercise solution for exercism platform"}
    author: "Rohan Kapri"
]

reverse-string: function [
    "Reverses a string"
    input [string!] "String to reverse"
    return: [string!]
] [
    output: copy ""
    foreach char reverse input [
        append output char
    ]
    output
]