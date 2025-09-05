;; for my Junko F. Didi and Shree DR.MDD

(defpackage :saddle-points
  (:use :cl)
  (:export :saddle-points))

(in-package :saddle-points)

(defmacro iter-matrix-2d ((ri ci val) mat &body body)
  (let ((tmp (gensym)))
    `(loop with ,tmp = ,mat
           for ,ri below (array-dimension ,tmp 0)
           do (loop for ,ci below (array-dimension ,tmp 1)
                    for ,val = (aref ,tmp ,ri ,ci)
                    do (progn ,@body)))))

(defmacro build-dim (mat dnum initv)
  `(make-array (array-dimension ,mat ,dnum) :initial-element ,initv))

(defmacro updatef (place fn &rest args)
  `(setf ,place (,fn ,place ,@args)))

(defun saddle-points (grid)
  (let* ((row-max (build-dim grid 0 most-negative-fixnum))
         (col-min (build-dim grid 1 most-positive-fixnum))
         out)
    (symbol-macrolet ((r-v (aref row-max r))
                      (c-v (aref col-min c)))
      (iter-matrix-2d (r c v) grid
        (updatef r-v max v)
        (updatef c-v min v))
      (iter-matrix-2d (r c v) grid
        (when (= v r-v c-v)
          (push (list (1+ r) (1+ c)) out)))
      out)))
