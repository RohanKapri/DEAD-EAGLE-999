(import (rnrs))

(define (pangram? phrase)
  (let ((lowercase-phrase (string-map char-downcase phrase)))
    (define (char-in-string? char str)
      (not (eq? (string-index str (lambda (c) (char=? c char))) #f)))
    (let loop ((chars (string->list "abcdefghijklmnopqrstuvwxyz")))
      (if (null? chars)
          #t
          (if (char-in-string? (car chars) lowercase-phrase)
              (loop (cdr chars))
              #f)))))