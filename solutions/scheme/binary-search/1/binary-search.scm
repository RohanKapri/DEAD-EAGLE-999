(import (rnrs))

;; Defines a binary search function that takes a sorted vector and a target value,
;; then attempts to find the target value within the vector.
(define (binary-search array target)
  ;; Initiates a recursive search loop with initial bounds set to the start and end of the vector.
  (let search-loop ((low 0) (high (- (vector-length array) 1)))
    (if (> low high)
        ;; If the low bound exceeds the high bound, the search space is empty,
        ;; and the target is not found in the vector.
        'not-found
        ;; Calculates the middle index of the current search bounds.
        (let ((mid (+ low (quotient (- high low) 2))))
          (cond
           ;; If the target is found at the mid index, return this index.
           ((= (vector-ref array mid) target) mid)
           ;; If the target is greater than the value at mid, search the right half of the vector.
           ((< (vector-ref array mid) target) (search-loop (+ mid 1) high))
           ;; Otherwise, search the left half of the vector.
           (else (search-loop low (- mid 1))))))))