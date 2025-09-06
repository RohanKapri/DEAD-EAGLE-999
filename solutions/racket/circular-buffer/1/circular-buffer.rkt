; Dedicated to Shree DR.MDD

#lang racket

(provide circular-buffer%)

(define circular-buffer%
  (class object%
    (super-new)
    (init capacity)
    (define buf-capacity capacity)
    (define buf-data (make-vector capacity))
    (define r-index 0)
    (define w-index 0)
    (define cnt 0)

    (define (empty?) (= cnt 0))
    (define (full?) (= cnt buf-capacity))
    (define (next-index idx) (modulo (add1 idx) buf-capacity))
    (define (inc-read) (set! r-index (next-index r-index)))
    (define (inc-write) (set! w-index (next-index w-index)))

    (define/public (clear)
      (set! r-index 0)
      (set! w-index 0)
      (set! cnt 0))

    (define/public (read)
      (if (empty?)
          (error "Error: The buffer is empty and cannot be read.")
          (let ([val (vector-ref buf-data r-index)])
            (inc-read)
            (set! cnt (- cnt 1))
            val)))

    (define/public (write val)
      (if (full?)
          (error "Error: The buffer is full.")
          (begin
            (vector-set! buf-data w-index val)
            (inc-write)
            (set! cnt (add1 cnt)))))

    (define/public (overwrite val)
      (if (full?)
          (begin
            (inc-read)
            (vector-set! buf-data w-index val)
            (inc-write))
          (begin
            (vector-set! buf-data w-index val)
            (inc-write)
            (unless (full?)
              (set! cnt (add1 cnt))))))))
