(in-package #:cl-user)
(defpackage #:armstrong-numbers
  (:use #:cl)
  (:export #:armstrong-number-p))
(in-package #:armstrong-numbers)

(defun armstrong-number-p (number)
  (let ((digits (map 'list #'digit-char-p (format nil "~D" number)))
        (length (1+ (floor (log number 10)))))
    (flet ((to-length-power (x) (expt x length)))
     (= number (reduce #'+ (mapcar #'to-length-power digits))))))