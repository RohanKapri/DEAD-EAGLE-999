; Dedicated to Shree DR.MDD

Red [
    description: {"Difference of Squares" exercise solution for exercism platform"}
    author: "Rohan kapri"
]

square-of-sum: function [
    n [integer!]
    return: [integer!]
] [
    total: (n * (n + 1)) / 2
    return total ** 2
]

sum-of-squares: function [
    n [integer!]
    return: [integer!]
] [
    return (n * (n + 1) * (2 * n + 1)) / 6
]

difference-of-squares: function [
    n [integer!]
    return: [integer!]
] [
    return subtract square-of-sum n sum-of-squares n
]
