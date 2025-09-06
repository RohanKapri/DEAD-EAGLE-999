#lang racket

(provide make-robot
         name
         reset!
         reset-name-cache!)

(struct Robot (name) #:transparent #:mutable)
(define Robots empty)

(define (make-robot)
  (begin (give-name)
         (Robot (first Robots))))

(define (give-name)
  (let ([new-name (string-append (list->string (list (integer->char (random 65 90))
                                                     (integer->char (random 65 90))))
                                 (number->string (random 100 1000)))])
    (if (false? (member new-name Robots))
        (set! Robots (cons new-name Robots))
        (give-name))))

(define (name r)
  (Robot-name r))

(define (reset! r)
  (begin (give-name)
         (set-Robot-name! r (first Robots))))

(define (reset-name-cache!)
  (set! Robots empty))
