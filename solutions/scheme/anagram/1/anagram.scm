(import (rnrs))

(define (string-sort str)
  (list->string (sort (string->list str) char<?)))

(define (normalize-word word)
  (string-sort (string-downcase word)))

(define (is-anagram? normalized-target original-target candidate)
  (and (not (string-ci=? original-target candidate))
       (string=? normalized-target (normalize-word candidate))))

(define (anagram target words)
  (let ((normalized-target (normalize-word target)))
    (filter (lambda (word) (is-anagram? normalized-target target word)) words)))