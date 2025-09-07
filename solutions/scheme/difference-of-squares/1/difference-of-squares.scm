(import (rnrs))

(define (square-of-sum n)
  (let ((sum (/ (* (+ n 1) n) 2))) ; Calculate the sum of the first N natural numbers
    (* sum sum))) ; Square the sum

(define (sum-of-squares n)
  (/ (* n (+ n 1) (+ (* 2 n) 1)) 6)) ; Correct placement of operations for sum of squares

(define (difference-of-squares n)
  (- (square-of-sum n) (sum-of-squares n))) ; Calculate the difference