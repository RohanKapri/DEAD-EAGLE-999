(defpackage :resistor-color-duo
  (:use :cl)
  (:export :value))

(in-package :resistor-color-duo)

(let ((all-colors (list "black" "brown" "red" "orange" "yellow" 
                        "green" "blue" "violet" "grey" "white")))
  (defun color-value (c)
    (position c all-colors :test #'string=)))

(defun value (colors)
  (destructuring-bind (a b &rest _) (mapcar #'color-value colors)
    (declare (ignore _))
    (+ (* 10 a) b)))