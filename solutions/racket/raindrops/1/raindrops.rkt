#lang racket

(provide convert)

(define (convert number)
  (let* ([sounds (list (if (zero? (remainder number 3)) "Pling" "")
                       (if (zero? (remainder number 5)) "Plang" "")
                       (if (zero? (remainder number 7)) "Plong" ""))]
         [result (string-join sounds "")])
    (if (string=? result "")
        (number->string number)
        result)))