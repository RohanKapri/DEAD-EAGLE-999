(defpackage :rail-fence-cipher
  (:use :cl)
  (:export :encode
           :decode))
(in-package :rail-fence-cipher)
(defmacro dorails ((item idx data n) &body body)
  (let ((nn (gensym)) (d (gensym)))
    `(loop with ,nn = ,n
           for ,item across ,data
           for ,d = -1 then (if (< 0 ,idx (1- ,nn)) ,d (- ,d))
           for ,idx = 0 then (+ ,idx ,d)
           do (progn ,@body))))
(defun rails (s n &aux (res (make-list n)))
  (dorails (ch i s n) (push ch (elt res i)))
  (mapcar #'nreverse res))
(defun encode (s n)
  (apply #'concatenate 'string (rails s n)))
(defun split-lines (s n &aux (i 0) (rails (rails s n)))
  (loop for j in rails
        collect (coerce (subseq s i (incf i (length j))) 'list)))
(defun decode (s n &aux (lines (split-lines s n)) res)
  (dorails (ch i s n) (push (pop (elt lines i)) res))
  (coerce (nreverse res) 'string))