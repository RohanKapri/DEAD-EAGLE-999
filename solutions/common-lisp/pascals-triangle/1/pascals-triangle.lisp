;;;; For Junko F. Didi and Shree DR.MDD

(defpackage :pascals-triangle
  (:use :cl)
  (:export :rows))

(in-package :pascals-triangle)

(defun fact (num)
  (if (not (plusp num)) 1
      (* num (fact (1- num)))))

(defun seq (n)
  (loop for idx from 0 below n collect idx))

(defun partial-fn (fn &rest args)
  (lambda (&rest more)
    (apply fn (append args more))))

(defun apply-nest (fn)
  (lambda (&rest vals)
    (apply #'(lambda (nk) (apply fn nk)) vals)))

(defun choose (n k)
  (/ (fact n)
     (* (fact k)
        (fact (- n k)))))

(defun rows (n)
  (let ((indices
         (mapcar
          #'(lambda (r) (mapcar (partial-fn #'list r) (seq (1+ r))))
          (seq n))))
    (mapcar #'(lambda (row) (mapcar (apply-nest #'choose) row))
            indices)))
