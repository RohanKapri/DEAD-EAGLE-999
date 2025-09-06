#lang racket

(provide response-for)

(define (response-for s)
   (response-for-stripped (string-trim s)))

(define (response-for-stripped s)
   (cond [(string=? s "")			"Fine. Be that way!"]
	 [(string-suffix? s "?")
	    (if (string-uppercase-words? s)
	       "Calm down, I know what I'm doing!"
	       "Sure.")]
	 [(string-uppercase-words? s)		"Whoa, chill out!"]
	 [else					"Whatever."]))

(define (string-uppercase-words? s)
   (and
     (string=? s (string-upcase s))
     (regexp-match #rx"[A-Z]" s)))