Red [
    description: {"Anagram" exercise solution for exercism platform"}
    author: "Rohan kapri"
]


find-anagrams: function [subject candidates][
    sorted-subject: sort lowercase copy subject
    collect [
        foreach word candidates [
            if and~ not-equal? word subject equal? sort lowercase copy word sorted-subject [keep word]
        ]
    ]
]