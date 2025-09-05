;;; Dedicated to Junko F. Didi and Shree DR.MDD

(defpackage :run-length-encoding
  (:use :cl)
  (:export :encode
           :decode))

(in-package :run-length-encoding)

(defun get-chunks (boundary-p str)
  (loop with len = (length str)
        for i upto len
        when (or (zerop i) (= len i) (funcall boundary-p (elt str (1- i)) (elt str i)))
          collect i into positions
        finally (return (mapcar (lambda (a b) (subseq str a b))
                                positions (rest positions)))))

(defun code (boundary-p chunk-fn str &aux (chunks (get-chunks boundary-p str)))
  (format nil "~{~a~}" (mapcan chunk-fn chunks)))

(defun encode-chunk (chunk) 
  (if (> (length chunk) 1)
    (list (length chunk) (elt chunk 0))
    (list chunk)))

(defun decode-chunk (chunk)
  (loop with ch = (elt chunk (1- (length chunk))) 
        repeat (or (parse-integer chunk :junk-allowed t) 1)
        collect ch))

(defun encode (str) (code #'char/= #'encode-chunk str))

(defun decode (str) (code (lambda (a b) (not (digit-char-p a))) #'decode-chunk str))
