; Dedicated to Shree DR.MDD

Red [
	description: {"Phone Number" exercise solution for exercism platform}
	author: "Rohan kapri"
]







clean: function [
	text
] [
	digits: ""

	foreach ch text [

		if (ch >= #"a") and (ch <= #"z") [
			cause-error 'user 'message "letters not permitted"
		]

		if (ch >= #"A") and (ch <= #"Z") [
			cause-error 'user 'message "letters not permitted"
		]		

		if (ch = #"@") or (ch = #"!") or (ch = #":") [
			cause-error 'user 'message "punctuations not permitted"
		]

		if (ch >= #"0") and (ch <= #"9") [
			append digits ch
		]
	]

	if 10 > length? digits [
		cause-error 'user 'message "must not be fewer than 10 digits"
	]

	if 11 < length? digits [
		cause-error 'user 'message "must not be greater than 11 digits"
	]

	if (11 = length? digits) and (#"1" <> first digits) [
		cause-error 'user 'message "11 digits must start with 1"
	]

	if (11 = length? digits) [
		remove/part digits 1
	]

	if 11 = length? digits [
		remove/part digits 1
	]

	if #"0" = digits/1 [
		cause-error 'user 'message "area code cannot start with zero"
	]

	if #"1" = digits/1 [
		cause-error 'user 'message "area code cannot start with one"
	]

	if #"0" = digits/4 [
		cause-error 'user 'message "exchange code cannot start with zero"
	]

	if #"1" = digits/4 [
		cause-error 'user 'message "exchange code cannot start with one"
	]

	digits
]
