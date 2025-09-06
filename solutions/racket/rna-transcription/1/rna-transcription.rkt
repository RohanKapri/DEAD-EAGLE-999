#lang racket

(provide to-rna)

(define (to-rna dna)
  (list->string
   (map
    (lambda (nucleotide)
      (case nucleotide
        [(#\G) #\C]
        [(#\C) #\G]
        [(#\T) #\A]
        [(#\A) #\U]
        [else (error "Invalid nucleotide: ~a" nucleotide)]))
    (string->list dna))))