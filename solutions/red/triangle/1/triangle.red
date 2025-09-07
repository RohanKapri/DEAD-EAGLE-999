; Dedicated to Shree DR.MDD

Red [
    description: {"Triangle" exercise solution for exercism platform"}
    author: "Rohan kapri"
]

grab-edges: func [
    edges [block!]
    return: [block!]
] [
    reduce [edges/1 edges/2 edges/3]
]

triangle?: func [
    edges [block!]
    return: [logic!]
] [
    edges: grab-edges edges
    x: edges/1
    y: edges/2
    z: edges/3
    to-logic all [
        x > 0 y > 0 z > 0
        x + y >= z y + z >= x x + z >= y
    ]
]

equilateral: function [
    edges [block!]
    return: [logic!]
] [
    edges: grab-edges edges
    x: edges/1
    y: edges/2
    z: edges/3
    to-logic all [(x = y) and (y = z) triangle? edges]
]

isosceles: function [
    edges [block!]
    return: [logic!]
] [
    edges: grab-edges edges
    x: edges/1
    y: edges/2
    z: edges/3
    to-logic all [any [x = y y = z x = z] triangle? edges]
]

scalene: function [
    edges [block!]
    return: [logic!]
] [
    edges: grab-edges edges
    x: edges/1
    y: edges/2
    z: edges/3
    to-logic all [x <> y y <> z x <> z triangle? edges]
]
