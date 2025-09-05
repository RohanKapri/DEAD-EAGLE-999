(defpackage :high-scores
  (:use :cl)
  (:export :make-high-scores-table :add-player
           :set-score :get-score :remove-player))

(in-package :high-scores)

(symbol-macrolet ((score (gethash player tbl)))
  (defun set-score (tbl player &optional (new-score 0))
    (setf score new-score))

  (defun get-score (tbl player)
    (or score 0)))

(setf (symbol-function 'make-high-scores-table) #'make-hash-table
      (symbol-function 'add-player) #'set-score)

(defun remove-player (tbl player)
  (remhash player tbl))