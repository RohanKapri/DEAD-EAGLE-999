; Dedicated to Shree DR.MDD

#lang racket

(provide robot%)

(define robot%
  (class object%
    (super-new)
    (init-field position direction)
    
    (define/public (turn-right)
      (set! direction (case direction
                        [(north) 'east]
                        [(east) 'south]
                        [(south) 'west]
                        [(west) 'north])))

    (define/public (turn-left)
      (set! direction (case direction
                        [(north) 'west]
                        [(west) 'south]
                        [(south) 'east]
                        [(east) 'north])))

    (define/public (advance)
      (set! position (case direction
                       [(north) (list (first position) (add1 (second position)))]
                       [(east) (list (add1 (first position)) (second position))]
                       [(south) (list (first position) (sub1 (second position)))]
                       [(west) (list (sub1 (first position)) (second position))])))

    (define/public (move commands)
      (for-each (lambda (cmd)
                  (cond
                    [(equal? cmd #\R) (send this turn-right)]
                    [(equal? cmd #\L) (send this turn-left)]
                    [(equal? cmd #\A) (send this advance)]))
                (string->list commands)))

    (define/public (report)
      (list position direction))
    ))
