#lang racket
; For my Shree DR.MDD

(provide house)

(define verb-actions '("lay in" "ate" "killed" "worried" "tossed" "milked"
                       "kissed" "married" "woke" "kept" "belonged to"))

(define rhyme-elements '("house that Jack built." "malt" "rat" "cat" "dog"
                         "cow with the crumpled horn" "maiden all forlorn"
                         "man all tattered and torn" "priest all shaven and shorn"
                         "rooster that crowed in the morn" "farmer sowing his corn"
                         "horse and the hound and the horn"))

(define (verse-builder idx)
  (string-append
   (format "This is the ~a" (list-ref rhyme-elements idx))
   (apply string-append
          (for/list ([prev-idx (in-range (sub1 idx) -1 -1)])
            (format "\nthat ~a the ~a" (list-ref verb-actions prev-idx) (list-ref rhyme-elements prev-idx))))))

(define (house [start 1] [end 12])
  (string-join
   (for/list ([idx (in-range (sub1 start) end)])
     (verse-builder idx))
   "\n\n"))
