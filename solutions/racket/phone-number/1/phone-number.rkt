#lang racket

(provide nanp-clean)

(require racket/string)

(define (nanp-clean s)
  (define digits (filter char-numeric? (string->list s)))
  (define cleaned-number
    (cond
      [(and (= (length digits) 11) (eq? (first digits) #\1)) (list->string (rest digits))]
      [(= (length digits) 10) (list->string digits)]
      [else (error "Invalid number length")]))
  (cond
    [(or (= (string->number (substring cleaned-number 0 1)) 0)
         (= (string->number (substring cleaned-number 0 1)) 1))
     (error "Invalid area code")]
    [(or (= (string->number (substring cleaned-number 3 4)) 0)
         (= (string->number (substring cleaned-number 3 4)) 1))
     (error "Invalid exchange code")]
    [else cleaned-number]))