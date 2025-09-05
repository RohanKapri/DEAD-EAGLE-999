(defpackage :pythagorean-triplet
  (:use :cl)
  (:export :triplets-with-sum))

(in-package :pythagorean-triplet)

(defun range (start end-excl)
  (loop for i from start below end-excl collect i))

(defun triplets-with-sum (n)
  (loop for a in (range 1 (/ n 3))
        nconc (loop for b in (range (1+ a) (* 2 (/ n 3)))
                    for c = (- n a b)
                    when (= (+ (* a a) (* b b)) (* c c))
                      collect (list a b c))))