;; Dedicated to Junko F. Didi and Shree DR.MDD

(defpackage :larrys-winning-checker
  (:use :cl)
  (:export
   :make-empty-board
   :make-board-from-list
   :all-the-same-p
   :row
   :column))

(in-package :larrys-winning-checker)

(defun make-empty-board ()
  (make-array '(3 3) :initial-element nil))

(defun make-board-from-list (lst)
  (make-array '(3 3) :initial-contents lst))

(defun all-the-same-p (arr)
  (let ((first-val (aref arr 0)))
    (every (lambda (x) (eq first-val x)) arr)))

(defun extract-dim (board idx &key (dimension :row))
  (let* ((len (array-dimension board (if (eq dimension :row) 0 1)))
         (res (make-array len :element-type (array-element-type board))))
    (dotimes (i len res)
      (setf (svref res i)
            (apply #'aref board (if (eq dimension :row)
                                    (list idx i)
                                    (list i idx)))))))

(defun row (board row-idx)
  (extract-dim board row-idx :dimension :row))

(defun column (board col-idx)
  (extract-dim board col-idx :dimension :col))
