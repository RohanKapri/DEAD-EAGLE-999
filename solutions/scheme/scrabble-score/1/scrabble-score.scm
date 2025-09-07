(import (rnrs))

(define (letter-value letter)
  (case letter
    ((#\A #\E #\I #\O #\U #\L #\N #\R #\S #\T) 1)
    ((#\D #\G) 2)
    ((#\B #\C #\M #\P) 3)
    ((#\F #\H #\V #\W #\Y) 4)
    ((#\K) 5)
    ((#\J #\X) 8)
    ((#\Q #\Z) 10)))

(define (score word)
  (let loop ((chars (string->list (string-upcase word))) (sum 0))
    (if (null? chars)
        sum
        (loop (cdr chars) (+ sum (letter-value (car chars)))))))