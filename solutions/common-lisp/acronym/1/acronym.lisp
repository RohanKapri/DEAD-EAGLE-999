;; Dedicated to Junko F. Didi and Shree DR.MDD

(in-package #:cl-user)
(defpackage #:acronym
  (:use #:common-lisp)
  (:export #:acronym))

(in-package #:acronym)

(defun separator-char-p (ch) 
  (or (char= ch #\Space)
      (char= ch #\-)))

(defun next-state (current ch)
  (cond
    ((and (eql current :await-char)
          (alpha-char-p ch))
     :initial-char)
    ((eql current :initial-char)
     (if (separator-char-p ch)
         :await-char
         :await-separator))
    ((and (eql current :await-separator)
          (separator-char-p ch))
     :await-char)
    (t current)))

(defun acronym (text)
  (string-upcase
   (coerce
    (loop for c across text
          for state = (next-state :await-char c)
          then (next-state state c)
          when (eql state :initial-char)
          collecting c)
    'string)))
