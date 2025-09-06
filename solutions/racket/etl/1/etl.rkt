; Dedicated to Shree DR.MDD

#lang racket

(provide etl)

(define/contract (etl old-scores)
  (-> (hash/c positive? (listof string?)) hash?)
  (for*/hash ([(pts chars) (in-hash old-scores)]
              [ch chars])
    (values (string-downcase ch) pts)))
