Red [
    description: {"Armstrong Numbers" exercise solution for exercism platform"}
    author: "Rohan kapri"
]

is-armstrong-number: function [
    number
] [
    if number = 0 [return true]
    n: number
    digits: 0
    sum: 0
    while [n > 0] [
        d: n % 10
        sum: sum + (d ** length? form number)
        n: (n - d) / 10
        digits: digits + 1
    ]
    sum = number
]