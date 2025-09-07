Red [
    description: {"Leap" exercise solution for exercism platform"}
    author: "Rohan Kapri"
]

leap: function [
    year [integer!]
    return: [logic!]
] [
    return year // 4 = 0 and either year // 100 <> 0 [true] [year // 400 = 0]
]