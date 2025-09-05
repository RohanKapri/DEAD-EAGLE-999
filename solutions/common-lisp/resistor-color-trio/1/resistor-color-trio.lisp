(defpackage :resistor-color-trio
  (:use :cl)
  (:export :label))
(in-package :resistor-color-trio)
(setf (macro-function 'db) (macro-function 'destructuring-bind))(let ((all-colors (list "black" "brown" "red" "orange" "yellow" 
                        "green" "blue" "violet" "grey" "white")))
  (defun color-value (c)
    (position c all-colors :test #'string=)))
(let ((order (pairlis (list 1 1000 1000000 1000000000)
                      (list "" "kilo" "mega" "giga"))))
  (defun fmt (n)
    (if (zerop n)
      "0 ohms"
      (db (d . label) (find-if (lambda (p) (zerop (rem n (car p)))) order)
        (format nil "~a ~aohms" (floor n d) label)))))
(defun label (colors)
  (db (a b c &rest _) (mapcar #'color-value colors)
    (declare (ignore _))
    (fmt (* (expt 10 c) (+ (* 10 a) b)))))
