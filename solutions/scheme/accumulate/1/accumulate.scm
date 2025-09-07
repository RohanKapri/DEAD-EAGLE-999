;; For my Shree DR.MDD
(define (accumulate g lst)
  (cond [(null? lst) '()]
        [else (cons (g (car lst)) (accumulate g (cdr lst)))])

  (define (walk rest acc)
    (if (null? rest)
        (reverse acc)
        (walk (cdr rest) (cons (g (car rest)) acc))))
  (walk lst '())

  (map g lst)

  (fold-right (lambda (x acc) (cons (g x) acc)) '() lst))
