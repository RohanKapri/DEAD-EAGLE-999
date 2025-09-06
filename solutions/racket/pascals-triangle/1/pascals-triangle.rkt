#lang racket

(provide rows)

(define (rows height)
  (if (= height 0)
      '()
      (let loop ([n 1] [prev-row '(1)])
        (if (= n height)
            (list prev-row)
            (let* ([left-shifted (append prev-row '(0))]
                   [right-shifted (cons 0 prev-row)]
                   [new-row (map + left-shifted right-shifted)])
              (append (list prev-row) (loop (add1 n) new-row)))))))