(defpackage #:isogram
  (:use #:cl)
  (:export #:isogram-p))

(in-package #:isogram)

(defun isogram-p (string)
  "Is string an Isogram?"
  (let ((normalized (string-downcase
                     (remove-if-not #'alpha-char-p string))))
    (string= normalized (remove-duplicates normalized))))