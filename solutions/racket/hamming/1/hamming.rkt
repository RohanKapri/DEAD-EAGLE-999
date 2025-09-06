#lang racket

(provide hamming-distance)

(define (hamming-distance source target)
  (if (not (= (string-length source) (string-length target)))
      (error "Sequences must be of equal length")
      (let loop ((i 0) (count 0))
        (if (< i (string-length source))
            (loop (add1 i)
                  (if (char=? (string-ref source i) (string-ref target i))
                      count
                      (add1 count)))
            count))))