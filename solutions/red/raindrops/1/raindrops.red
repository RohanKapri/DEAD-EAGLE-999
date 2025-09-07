Red [
    description: {"Raindrops" exercise solution for exercism platform"}
    author: "Rohan Kapri"
]

convert: function [
    number [integer!]
    return: [string!]
] [
    result: copy ""

    if number // 3 = 0 [append result "Pling"]
    if number // 5 = 0 [append result "Plang"]
    if number // 7 = 0 [append result "Plong"]

    if result = "" [result: form number]

    return result
]