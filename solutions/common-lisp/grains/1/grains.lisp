(defpackage #:grains
  (:use #:cl)
  (:export #:square #:total))
(in-package #:grains)

(defparameter *board-size* 64
  "Traditional number of squares on a chess board.")

(defun square (n)
  "Compute the number of grains on a particular square of the game board."
  (expt 2 (1- n)))

(defun total (&optional (board-size *board-size*))
  "Compute the total number of grains given BOARD-SIZE."
  (loop for i from 1 upto board-size summing (square i)))