(defpackage :sieve
  (:use :cl)
  (:export :primes-to)
  (:documentation "Generates a list of primes up to a given limit."))

(in-package :sieve)

(defun primes-to (n)
  "List primes up to `n' using sieve of Eratosthenes."
  (let ((primes (loop for i from 2 to n collect i))
        (p 2))
    (loop while (<= (* p p) n)
          do (setf primes (remove-if (lambda (x) (and (not (eq x p))
                                                      (zerop (mod x p))))
                                     primes))
          do (setf p (find-if (lambda (x) (> x p)) primes)))
    primes))