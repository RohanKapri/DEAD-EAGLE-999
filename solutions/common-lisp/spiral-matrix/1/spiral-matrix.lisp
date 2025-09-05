(defpackage :spiral-matrix
  (:use :cl)
  (:export :spiral-matrix))

(in-package :spiral-matrix)

(defparameter *steps* '#1=((0 1) (1 0) (0 -1) (-1 0) . #1#))

(defun repeat (n item)
  (loop repeat n collect item))

(defun steps (side)
  (loop for s from (1- side) above 0
        nconc (list s s) into res
        finally (return (mapcan #'repeat (cons (1- side) res) *steps*))))

(defun spiral-matrix (side)
  (when (plusp side)
    (loop with res = (make-array (list side side) :initial-element (* side side))
          for i from 1
          for step in (steps side)
          and pos = (list 0 0) then (mapcar #'+ pos step)
          do (setf (apply #'aref res pos) i)
          finally (return res))))