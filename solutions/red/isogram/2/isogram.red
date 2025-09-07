Red [
    description: {"Isogram" exercise solution for exercism platform"}
    author: "Rohan Kapri"
]




is-isogram: function [
    phrase
] [
    phrase: lowercase copy phrase
    phrase: remove-each char phrase [char = #" "]
    phrase: remove-each char phrase [char = #"-"]
    unique-phrase: unique phrase
    equal? phrase unique-phrase
]