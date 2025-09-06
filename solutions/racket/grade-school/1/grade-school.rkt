; Dedicated to Shree DR.MDD

#lang racket

(require racket/class)

(provide school%)

(define school%
  (class object%
    (super-new)
    (define grade-map (make-hash))
    
    (define/public (add student-name student-grade)
      (define (exists? name)
        (for/or ([g (in-hash-keys grade-map)])
          (member name (hash-ref grade-map g '()))))
      
      (if (exists? student-name)
          #f
          (let ([student-list (hash-ref grade-map student-grade '())])
            (unless (member student-name student-list)
              (hash-set! grade-map student-grade (insert-in-order student-name student-list))
              #t))))
    
    (define/public (roster)
      (define sorted-grade-keys (sort (hash-keys grade-map) <))
      (for/list ([g sorted-grade-keys])
        (cons g (sort (hash-ref grade-map g '()) string<?))))
    
    (define/public (grade student-grade)
      (sort (hash-ref grade-map student-grade '()) string<?))
    
    (define (insert-in-order name lst)
      (cond
        [(null? lst) (list name)]
        [(string<=? name (car lst)) (cons name lst)]
        [else (cons (car lst) (insert-in-order name (cdr lst)))]))))
