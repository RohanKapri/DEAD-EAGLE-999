(defpackage :matrix
  (:use :cl)
  (:export :row
           :column))

(in-package :matrix)

(defun read-all (s)
  (loop with stm = (make-string-input-stream s)
        for x = (read stm nil)
        while x collect x))

(defun count-first-line (s)
  (length (read-all (subseq s 0 (position #\newline s)))))

(defun parse (s)
  (loop with cols = (count-first-line s)
        for r on (read-all s) by (lambda (r) (nthcdr cols r))
        collect (subseq r 0 cols)))

(defun row (input-matrix index)
  (nth (1- index) (parse input-matrix)))

(defun column (input-matrix index)
  (let ((m (parse input-matrix)))
    (mapcar (lambda (r) (nth (1- index) r)) m)))