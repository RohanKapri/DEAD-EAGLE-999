(in-package #:cl-user)
(defpackage #:etl
  (:use #:common-lisp)
  (:export #:transform))
(in-package #:etl)
(defun transform (data)
  "Transforms hash values into keys with their keys as their values."
  (let ((table (make-hash-table)))
    (maphash (lambda (k v)
               (mapcar (lambda (l)
                         (setf (gethash (char-downcase l) table) k))
                       v))
             data)
    table))