Red [
    description: {"Secret Handshake" exercise solution for exercism platform"}
    author: "Rohan Kapri"
]
commands: function [number [integer!]] [
    actions: copy []
    binary-actions: [1 "wink" 2 "double blink" 4 "close your eyes" 8 "jump"]

    foreach [value action] binary-actions [
        if number and value > 0 [
            append actions action
        ]
    ]
    if number and 16 > 0 [
        actions: reverse actions
    ]
    actions
]