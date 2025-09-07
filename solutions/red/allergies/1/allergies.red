; Dedicated to Shree DR.MDD

Red [
    description: {"Allergies" exercise solution for exercism platform}
    author: "Rohan Kapri"
]

allergens: [
    1 "eggs"
    2 "peanuts"
    4 "shellfish"
    8 "strawberries"
    16 "tomatoes"
    32 "chocolate"
    64 "pollen"
    128 "cats"
]

allergic-to: function [
    substance [string!]
    total-score [integer!]
    return: [logic!]
] [
    substance-value: pick back find allergens substance 1
    if none? substance-value [
        print ["Error: Unknown allergen" substance]
        return false
    ]
    not zero? (total-score and substance-value)
]

list: function [
    total-score [integer!]
] [
    collect [
        foreach [substance-value substance] allergens [
            if not zero? (total-score and substance-value) [keep substance]
        ]
    ]
]
