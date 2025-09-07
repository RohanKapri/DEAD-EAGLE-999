Red [
    description: "Darts exercise solution for Exercism platform"
    author: "Rohan Kapri"
]
score: function [
    coordinateX [number!] "X-coordinate of the dart's landing point"
    coordinateY [number!] "Y-coordinate of the dart's landing point"
    /local distanceFromCenter
] [
    distanceFromCenter: square-root ((coordinateX ** 2) + (coordinateY ** 2))
    case [
        distanceFromCenter <= 1  [10] ; Score for landing in the inner circle
        distanceFromCenter <= 5  [5]  ; Score for landing in the middle circle
        distanceFromCenter <= 10 [1]  ; Score for landing in the outer circle
        true                  [0]     ; Score for missing the target
    ]
]