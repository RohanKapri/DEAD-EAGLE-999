Red [
    description: {"ETL" exercise solution for exercism platform}
    author: "Rohan Kapri"
]

transform: function [legacy] [
    result: make map! []
    
    foreach [score letters] legacy [
        foreach letter letters [
            put result to word! lowercase letter to integer! score
        ]
    ]
    
    result
]