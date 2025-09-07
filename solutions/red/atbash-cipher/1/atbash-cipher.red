; Dedicated to Shree DR.MDD

Red [
	description: {"Atbash Cipher" exercise solution for exercism platform}
	author: "Rohan kapri"
]

atbash: function [
    symbol [char!]
    return: [char! none!]
] [
    case [
        (symbol >= 97) and (symbol <= 122) [ to char! (219 - to integer! symbol) ]
        (symbol >= 48) and (symbol <= 57) [ symbol ]
        true [ none ]
    ]
]

encode: function [
	phrase [string!]
    /no-ciphertext
] [
    lower-str: lowercase copy phrase
    idx: 0
	to string! collect [
        foreach symbol lower-str [
            cipher-symbol: atbash symbol
            if not none? cipher-symbol [
                if (not no-ciphertext) and (idx // 5 = 0) and (idx <> 0) [
                    keep #" "
                ]
                keep cipher-symbol
                idx: idx + 1
            ]
        ]
    ]
]

decode: function [
	phrase [string!]
] [
	encode/no-ciphertext phrase
]
