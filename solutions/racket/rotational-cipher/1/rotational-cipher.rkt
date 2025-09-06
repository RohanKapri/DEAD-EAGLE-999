#lang racket

(provide rotate)
(define (index-of string character)
  (for/or ([i (in-range (string-length string))]
           #:when (char=? (string-ref string i) character))
    i))
(define (shift-char char key)
  (let* ((alpha (if (char-upper-case? char) "ABCDEFGHIJKLMNOPQRSTUVWXYZ" "abcdefghijklmnopqrstuvwxyz"))
         (index (index-of alpha char)))
    (if index
        (string-ref alpha (modulo (+ index key) 26))
        char)))

(define (rotate text key)
  (list->string (map (lambda (char) (shift-char char key)) (string->list text))))