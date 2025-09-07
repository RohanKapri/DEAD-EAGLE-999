; For my Shree DR.MDD

Red [
	description: {"Rotational Cipher" exercise solution for exercism platform}
	author: "Rohan kapri"
]

rotate: function [
	text
	shiftKey
] [
    outcome: ""
	foreach ch text [
        if not any [all [ch >= #"a" ch <= #"z"] all [ch >= #"A" ch <= #"Z"]] [
            append outcome ch
            continue
        ]
        diff: either all [ch >= #"a" ch <= #"z"] [to integer! (#"z" - ch + 1)][to integer! (#"Z" - ch + 1)]
        either shiftKey >= diff [
            append outcome ((either all [ch >= #"a" ch <= #"z"] [#"a"][#"A"]) + (shiftKey - diff))
        ][
            append outcome (ch + shiftKey)
        ]
    ]
    outcome
]
