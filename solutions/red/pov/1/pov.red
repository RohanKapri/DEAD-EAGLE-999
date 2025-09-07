; For my Shree DR.MDD

Red [
    description: {"POV" exercise solution for exercism platform"}
    author: "Rohan kapri"
]

track: copy []

seek-node: function [
    node [map!]
    tag  [string!]
][
    case [
        node/label = tag [return node]
        block? kids: node/children [
            insert track node
            foreach k kids [
                if hit: seek-node k tag [return hit]
            ]
            remove track
        ]
    ]
    none
]

from-pov: function [
    root [map!]
    tag  [string!]
] [
    clear track
    if newRoot: cur: seek-node root tag [
        while [par: take track] [
            remove find par/children cur
            if empty? par/children [remove/key par 'children]
            either block? subs: cur/children [
                append subs par
            ][
                cur/children: reduce [par]
            ]
            cur: par
        ]
        newRoot
    ]
]

path-to: function [
    src [string!]
    dst [string!]
    tree [map!]
] [
    all [
        sNode: from-pov tree src
        dNode: seek-node sNode dst
        append reverse collect [
            foreach step track [
                keep step/label
            ]
        ] dNode/label
    ]
]
