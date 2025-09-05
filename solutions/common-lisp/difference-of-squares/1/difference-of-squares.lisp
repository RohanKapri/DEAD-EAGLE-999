(defpackage :difference-of-squares
  (:use :cl)
  (:export :sum-of-squares
           :square-of-sum
           :difference))
(in-package :difference-of-squares)
(defun |[-reader| (stream char)
  (declare (ignore char))
  (let ((pair (read-delimited-list #\] stream t)))
    `(loop for i from ,(first pair) upto ,(second pair) collecting i)))
(set-macro-character #\[ #'|[-reader|)
(set-macro-character #\] (get-macro-character #\) nil))
(defun square (x) (* x x))
(defun square-of-sum (x) (square (reduce #'+ [1 x])))
(defun sum-of-squares (x) (reduce #'+ (mapcar #'square [1 x])))
(defun difference (x) (- (square-of-sum x) (sum-of-squares x)))