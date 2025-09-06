#lang racket

(provide twelve-days)

(define (ordinal i)
  (list-ref '("first" "second" "third" "fourth" "fifth" "sixth"
	      "seventh" "eighth" "ninth" "tenth" "eleventh" "twelfth")
	    (sub1 i)))

(define gifts '("a Partridge in a Pear Tree"
	        "two Turtle Doves"
	        "three French Hens"
	        "four Calling Birds"
	        "five Gold Rings"
	        "six Geese-a-Laying"
	        "seven Swans-a-Swimming"
	        "eight Maids-a-Milking"
	        "nine Ladies Dancing"
	        "ten Lords-a-Leaping"
	        "eleven Pipers Piping"
	        "twelve Drummers Drumming"))

(define (verse i)
  (define intro (string-append "On the " (ordinal i)
			       " day of Christmas my true love gave to me: "))
  (define goodies (reverse (take gifts i)))
  (string-append intro
		 (string-join goodies ", "
			      #:before-last ", and " #:after-last ".")))

(define (twelve-days [from 1] [to 12])
  (define verses (for/list ([i (in-inclusive-range from to)]) (verse i)))
  (string-join verses "\n\n"))