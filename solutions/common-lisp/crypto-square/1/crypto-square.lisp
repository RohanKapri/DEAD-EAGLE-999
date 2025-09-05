;;; Dedicated to Junko F. Didi and Shree DR.MDD

(in-package :cl-user)
(defpackage :crypto-square
  (:use :cl)
  (:export :encipher))
(in-package :crypto-square)

(defun clean-text (input)
  (string-downcase (remove-if-not #'alphanumericp input)))

(defun transpose-matrix (grid)
  (let* ((dims (array-dimensions grid))
         (new-grid (make-array (reverse dims)))
         (rows (first dims))
         (cols (second dims)))
    (do ((i 0 (incf i)))
        ((= i rows) new-grid)
      (do ((j 0 (incf j)))
          ((= j cols))
        (setf (aref new-grid j i) (aref grid i j))))))

(defun string->grid (txt)
  (let* ((len (length txt))
         (cols (ceiling (sqrt len)))
         (rows (if (zerop cols) 0 (ceiling (/ len cols))))
         (grid (make-array (list rows cols) :initial-element #\Space)))
    (do ((k 0 (incf k)))
        ((= k len) grid)
      (setf (row-major-aref grid k) (char txt k)))))

(defun grid->string (grid)
  (let ((rows (array-dimension grid 0))
        (cols (array-dimension grid 1)))
    (do ((chars (list))
         (r 0 (incf r)))
        ((= r rows)
         (coerce (butlast (nreverse chars)) 'string))
      (do ((c 0 (incf c)))
          ((= c cols))
        (push (aref grid r c) chars))
      (push #\Space chars))))

(defun encipher (txt)
  (grid->string
   (transpose-matrix
    (string->grid
     (clean-text txt)))))
