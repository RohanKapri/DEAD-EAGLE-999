(defpackage :queen-attack
  (:use :cl)
  (:export :valid-position-p
           :attackp))

(in-package :queen-attack)

(defun valid-position-p (coordinates)
  (destructuring-bind (x . y) coordinates
    (and (<= 0 x 7) (<= 0 y 7))))

(defun attackp (white-queen black-queen)
  (destructuring-bind ((x1 . y1) (x2 . y2)) (list white-queen black-queen)
    (or (= x1 x2) (= y1 y2)
        (= (abs (- x1 x2)) (abs (- y1 y2))))))