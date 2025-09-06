#lang racket
(provide high-scores%)
(define high-scores%
  (class object%
    (init-field values)
    (define/public (scores)
      values)
    (define/public (latest)
      (last values))
    (define/public (personal-best)
      (apply max values))
    (define/public (personal-top-three)
      (let ([sorted-values (sort values >)])
        (take sorted-values (min (length sorted-values) 3))))
    (super-new)))