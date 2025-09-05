(in-package #:cl-user)
(defpackage #:anagram
  (:use #:common-lisp)
  (:export #:anagrams-for))

(in-package #:anagram)
(defun anagrams-for (word candidates)
  (flet ((sort-chars (word) (sort (copy-seq word) #'char-lessp)))
    (let ((word-sorted (sort-chars word)))
      (remove-if-not
       (lambda (candidate)
         (and (string-not-equal word candidate)
              (string-equal word-sorted (sort-chars candidate))))
       candidates))))