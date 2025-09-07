(import (rnrs))

(define (rotate-char c dx)
  (let ((base (if (char-upper-case? c) (char->integer #\A) (char->integer #\a))))
    (if (char-alphabetic? c)
        (integer->char (+ base (modulo (+ (- (char->integer c) base) dx) 26)))
        c)))

(define (rotate phrase dx)
  (list->string (map (lambda (c) (rotate-char c dx)) (string->list phrase))))