#lang racket

(provide pangram?)

(define (pangram? sentence)
  (let* ([letters (string->list (string-downcase sentence))]
         [alphabet (string->list "abcdefghijklmnopqrstuvwxyz")]
         [unique-letters (remove-duplicates letters char=?)]
         [alphabet-in-sentence (filter (lambda (c) (member c unique-letters char=?)) alphabet)])
    (equal? alphabet alphabet-in-sentence)))