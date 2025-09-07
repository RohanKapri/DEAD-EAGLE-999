(import (rnrs))

(define (roman n)
  (define roman-values
    '((1000 . "M") (900 . "CM") (500 . "D") (400 . "CD")
      (100 . "C") (90 . "XC") (50 . "L") (40 . "XL")
      (10 . "X") (9 . "IX") (5 . "V") (4 . "IV") (1 . "I")))

  (define (find-roman numeral value)
    (if (null? numeral)
        ""
        (let ((pair (car numeral)))
          (if (>= value (car pair))
              (string-append (cdr pair) (find-roman roman-values (- value (car pair))))
              (find-roman (cdr numeral) value)))))

  (find-roman roman-values n))