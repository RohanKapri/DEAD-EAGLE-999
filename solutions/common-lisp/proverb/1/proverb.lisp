(defpackage :proverb
  (:use :cl)
  (:export :recite))

(in-package :proverb)

(defun recite (data)
  (apply #'concatenate 'string
         (when data
           (loop for a in data
                 for b in (rest data)
                 collect (format nil "For want of a ~a the ~a was lost.~%" a b) 
                   into res
                 finally (return
                           (append res
                                   (list (format nil "And all for the want of a ~a." 
                                                 (car data)))))))))