(defpackage #:prime-factors
  (:use #:common-lisp)
  (:export :factors))

(in-package #:prime-factors)

(defun factors (n)
  (do ((candidate 2 (incf candidate))
       (primes (list)))
      ((> candidate n) (sort primes #'<))
    (setq n
          (do ((i n (floor i candidate)))
              ((not (zerop (mod i candidate))) i)
            (push candidate primes)))))