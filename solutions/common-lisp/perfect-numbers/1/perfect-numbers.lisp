(defpackage #:perfect-numbers
  (:use #:common-lisp)
  (:export #:classify))
(in-package #:perfect-numbers)
(defun divs-sum (m n)
  (multiple-value-bind (res r) (truncate (/ m n))
    (if (zerop r)
        (if (= res n)
            res
            (+ res n))
        0)))
(defun factors-sum (n)
  (if (= n 1) 0
      (1+
       (loop for x from 2 to (sqrt n) sum (divs-sum n x)))))
(defun classify (n)
  (when (plusp n)
    (let ((dsum (factors-sum n)))
      (cond ((= dsum n) "perfect")
            ((< dsum n) "deficient")
            (t "abundant")))))