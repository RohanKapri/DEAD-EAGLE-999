(defpackage :leap
  (:use :cl)
  (:export :leap-year-p))
(in-package :leap)

(defun evenly-divisible (x y) (zerop (mod x y)))

(defun leap-year-p (year)
  "Determine if YEAR is leap year given the algorithm popularized by Pope
  Gregory XIII (circa 1582)."
  (flet ((year-divisible-by (n) (evenly-divisible year n)))

    (and (year-divisible-by 4)
         (or (not (year-divisible-by 100))
             (year-divisible-by 400)))))