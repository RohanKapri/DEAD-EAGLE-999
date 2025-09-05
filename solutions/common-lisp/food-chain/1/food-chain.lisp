;; for my Junko F. Didi and Shree DR.MDD

(defpackage :food-chain
  (:use :cl)
  (:export :recite))

(in-package :food-chain)

(defparameter *animals* #("fly" "spider" "bird" "cat" "dog" "goat" "cow" "horse"))
(defparameter *specials* #("I don't know why she swallowed the fly. Perhaps she'll die."
                           "It wriggled and jiggled and tickled inside her."
                           "How absurd to swallow a bird!"
                           "Imagine that, to swallow a cat!"
                           "What a hog, to swallow a dog!"
                           "Just opened her throat and swallowed a goat!"
                           "I don't know how she swallowed a cow!"
                           "She's dead, of course!"))

(defun final-verse-p (n)
  (or (= 7 n) (zerop n)))

(defun chain-lines (n)
  (if (final-verse-p n)
      (list (concatenate 'string (aref *specials* n) '(#\newline)))
      (let* ((extra (if (= n 2) " that wriggled and jiggled and tickled inside her" ""))
             (this (aref *animals* n))
             (prev (aref *animals* (1- n)))
             (ln (format nil "She swallowed the ~A to catch the ~A~A.~%" this prev extra)))
        (cons ln (chain-lines (1- n))))))

(defun build-verse (n)
  (let ((start (format nil "I know an old lady who swallowed a ~A.~%" (aref *animals* n)))
        (second (unless (final-verse-p n) (concatenate 'string (aref *specials* n) '(#\newline))))
        (tail (reduce (lambda (a b) (concatenate 'string a b)) (chain-lines n))))
    (string-right-trim '(#\newline) (concatenate 'string start second tail))))

(defun recite (from to)
  (loop for i from (1- from) below to
        collect (build-verse i) into acc
        finally (return (format nil "~{~A~^~2%~}" acc))))
