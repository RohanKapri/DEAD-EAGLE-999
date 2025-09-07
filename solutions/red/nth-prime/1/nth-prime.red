; Dedicated to Shree DR.MDD

Red [
	description: {"Nth Prime" exercise solution for exercism platform}
	author: "Rohan kapri"
]

prime: function [
	pos
] [
	if pos == 0 [
		cause-error 'user 'message "there is no zeroth prime"
	]

	if pos == 1 [return 2]

	count: 1
	check: 1
	while [count < pos] [
		check: check + 2
		if prime? check [
			count: count + 1
		]
	]
	check
]

prime?: function [
	val
] [
	if val <= 1 [return false]
	if val == 2 [return true]
	if val % 2 == 0 [return false]

	tester: 3
	while [tester * tester <= val] [
		if val % tester == 0 [return false]
		tester: tester + 2
	]
	true
]
