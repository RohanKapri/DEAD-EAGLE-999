#lang racket

(provide anagrams-for)

(define (anagrams-for subject candidates)
  (define (sort-string s)
    (list->string (sort (string->list s) char<?)))
  (define sorted-subject (sort-string (string-downcase subject)))
  (filter (lambda (candidate)
            (and (not (string-ci=? subject candidate))
                 (string=? sorted-subject (sort-string (string-downcase candidate)))))
          candidates))