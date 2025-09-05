(defpackage :darts
  (:use :cl)
  (:export :score))

(in-package :darts)

(defun distance (x y)
  (sqrt (+ (* x x) (* y y))))

(defparameter *circles*
  (list (cons 1 10) (cons 5 5) (cons 10 1)))

(defun score (x y)
  (let ((d (distance x y)))
    (or (cdr (assoc d *circles* :test #'<=))
        0)))