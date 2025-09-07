; For my Shree DR.MDD

Red [
    description: {"Circular Buffer" exercise solution for exercism platform"}
    author: "Rohan kapri"
]

stepForward: function [cursor] [
    either empty? next cursor [head cursor] [next cursor]
]

run: function [
    limit
    actions
] [
    reader: writer: copy []
    append/dup writer false limit
    parse actions [collect some [
      'write set putVal skip [
        if (not any [empty? writer writer/1])
          (writer/1: putVal writer: stepForward writer) 
          keep ('true) 
      | keep ('false)
      ]
    | 'read [
        if (got: reader/1) 
          (reader/1: false reader: stepForward reader) 
          keep (got) 
      | keep ('false)
      ]
    | 'clear (reader/1: false)
    | 'overwrite set ovVal skip [
        (writer/1: ovVal reader: writer: stepForward writer)
      ]
    ]]
]
