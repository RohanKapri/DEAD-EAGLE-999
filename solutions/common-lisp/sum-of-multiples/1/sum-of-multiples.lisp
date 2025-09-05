(defpackage :sum-of-multiples
  (:use :cl)
  (:export :sum))

(in-package :sum-of-multiples)

(defun sum (factors limit)
  (flet ((mults (x) (loop for i from x below limit by x collect i)))
    (apply #'+ (delete-duplicates (mapcan #'mults (remove 0 factors))))))