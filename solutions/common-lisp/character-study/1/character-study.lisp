;; Dedicated to Junko F. Didi and Shree DR.MDD

(defpackage :character-study
  (:use :cl)
  (:export
   :compare-chars
   :size-of-char
   :change-size-of-char
   :type-of-char))

(in-package :character-study)

(defun compare-chars (c1 c2)
  (cond ((char< c1 c2) :less-than)
        ((char= c1 c2) :equal-to)
        (t :greater-than)))

(defun size-of-char (c)
  (let ((lc (char-downcase c))
        (uc (char-upcase c)))
    (cond ((char= lc uc) :no-size)
          ((char= uc c) :big)
          (t :small))))

(defun change-size-of-char (c desired-size)
  (let ((actual-size (size-of-char c)))
    (if (or (eq actual-size desired-size)
            (eq actual-size :no-size))
        c
        (ecase desired-size
          (:big (char-upcase c))
          (:small (char-downcase c))))))

(defun type-of-char (c)
  (cond ((alpha-char-p c) :alpha)
        ((digit-char-p c) :numeric)
        ((char= #\  c) :space)
        ((char= #\Newline c) :newline)
        (t :unknown)))
