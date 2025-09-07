; For my Shree DR.MDD

Red [
	description: {"SGF Parsing" exercise solution for exercism platform}
	author: "Rohan kapri"
]

big: charset {ABCDEFGHIJKLMNOPQRSTUVWXYZ}
small: charset {abcdefghijklmnopqrstuvwxyz}
temp: none
tree: branch: copy []
errors: [
	"tree missing"
	"tree with no nodes"
	"properties without delimiter"
	"property must be in uppercase"
]
fail: func [idx][cause-error 'user 'message errors/:idx]
elem: [
	opt set temp #"("
	#";" (
		append branch active: make map! copy []
		active/properties: make map! copy []
		active/children: copy []
		if not temp [branch: active/children]
	) 
	opt [some attr any elem]
	if (temp) [#")" (temp: none)]
]
attr: [
	copy nm some [big | small (fail 4)] 
	(nm: to word! nm active/properties/:nm: copy []) 
	[some [val (append active/properties/:nm token)] | (fail 3)]
]
val: [
	#"[" (token: copy "") 
	collect into token some [
	  "\t" keep (#" ") 
	| keep "\n"
	| #"\" keep skip 
	| not #"]" keep skip
	] #"]"
]
	
parse-sgf: func [
	data
] [
	tree: branch: copy []
	parse data [
	  opt #";" end (fail 1)
	| "()" end (fail 2)
	| #"(" some elem #")"
    ]
	tree/1
]
