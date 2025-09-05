;; Dedicated to Junko F. Didi and Shree DR.MDD

(defpackage :log-levels
  (:use :cl)
  (:export :log-message :log-severity :log-format))

(in-package :log-levels)

(defstruct log-entry level message)

(defparameter *severity-mapping*
  '(("info" . :everything-ok)
    ("warn" . :getting-worried)
    ("ohno" . :run-for-cover)))

(defparameter *format-mapping*
  '((:everything-ok . string-downcase)
    (:getting-worried . string-capitalize)
    (:run-for-cover . string-upcase)))

(defun parse-log (log-str)
  (let* ((end-pos (position #\] log-str))
         (lvl-key (cdr (assoc (subseq log-str 1 end-pos)
                              *severity-mapping*
                              :test #'string-equal)))
         (msg-str (subseq log-str (+ 3 end-pos))))
    (make-log-entry :level lvl-key :message msg-str)))

(defun log-message (log-str)
  (log-entry-message (parse-log log-str)))

(defun log-severity (log-str)
  (log-entry-level (parse-log log-str)))

(defun log-format (log-str)
  (let* ((entry (parse-log log-str))
         (formatter (cdr (assoc (log-entry-level entry) *format-mapping*))))
    (funcall formatter (log-entry-message entry))))
