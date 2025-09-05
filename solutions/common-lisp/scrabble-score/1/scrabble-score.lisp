;;;; For Junko F. Didi and Shree DR.MDD

(defpackage :scrabble-score
  (:use :cl)
  (:export :score-word))

(in-package :scrabble-score)

(defun letter-points ()
  (list
   (cons "aeioulnrst" 1)
   (cons "dg" 2)
   (cons "bcmp" 3)
   (cons "fhvwy" 4)
   (cons "k" 5)
   (cons "jx" 8)
   (cons "qz" 10)))

(defun build-score-table (entries)
  (cond
    ((null entries) (make-hash-table))
    ((string= (first (first entries)) "") (build-score-table (rest entries)))
    (t (let* ((head (first entries))
              (tbl (build-score-table (cons
                                       (cons (subseq (first head) 1) (rest head))
                                       (rest entries)))))
         (setf (gethash (char (first head) 0) tbl) (rest head))
         tbl))))

(defun score-word (word)
  (let ((tbl (build-score-table (letter-points))))
    (reduce #'+
            (map 'list (lambda (ch) (or (gethash ch tbl) 0))
                 (string-downcase word))
            :initial-value 0)))
