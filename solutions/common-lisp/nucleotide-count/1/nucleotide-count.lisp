(defpackage :nucleotide-count
  (:use :cl)
  (:export :nucleotide-counts))

(in-package :nucleotide-count)

(defun nucleotide-counts (strand)
  (loop for i from 0 below (length strand)
        with num-a = 0 and num-c = 0 and num-g = 0 and num-t = 0
    do (case (char strand i)
         (#\A (incf num-a))
         (#\C (incf num-c))
         (#\G (incf num-g))
         (#\T (incf num-t))
         (otherwise (return-from nucleotide-counts (format t "ERROR: ~a not valid as nucleotide." (char strand i)))))
    finally (return (list (cons #\A num-a) (cons #\C num-c) (cons #\G num-g) (cons #\T num-t)))))