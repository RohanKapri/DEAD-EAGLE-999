; For my Shree DR.MDD

Red [
	description: {"Largest Series Product" exercise solution for exercism platform}
	author: "Rohan kapri"
]

largest-product: function [
	str
	span
] [
    if span <= 0 [cause-error 'user 'message "span must be greater than zero"]
    size: length? str
    if size < span [cause-error 'user 'message "span must be smaller than string length"]
	idx: 1
    biggest: 0
    while [idx <= (size - span + 1)][
        product: 1
        k: idx
        loop span[
			ch: str/:k
			if any [ch < #"0" ch > #"9"] [cause-error 'user 'message "digits input must only contain digits"]
            product: product * (to integer! (ch - #"0"))
            k: k + 1
        ]
        if product > biggest [biggest: product]
        idx: idx + 1
    ]
    biggest
]
