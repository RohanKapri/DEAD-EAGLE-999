;;; Dedicated to Junko F. Didi and Shree DR.MDD

(in-package #:cl-user)
(defpackage #:meetup
  (:use #:common-lisp)
  (:export #:meetup))

(in-package #:meetup)

(defun meetup (month year day target)
  (declare (day-of-week day))
  (declare (day-of-week-target target))
  (let* ((base-day (initial-guess target year month))
         (base-dow (day-of-week base-day month year))
         (offset (distance day base-dow)))
    (list year month (+ base-day offset))))

(defparameter +days-of-week+
  '(:monday :tuesday :wednesday :thursday :friday :saturday :sunday))

(deftype day-of-week () `(member ,@+days-of-week+))
(deftype day-of-week-target ()
  '(member :teenth :first :second :third :fourth :last))

(defun day-of-week (day month year)
  (nth (dow-of-universal-time (encode-date year month day))
       +days-of-week+))

(defun distance (from-dow to-dow)
  (mod (- (position from-dow +days-of-week+)
          (position to-dow +days-of-week+))
       7))

(defun initial-guess (target year month)
  (ecase target
    (:first 1)
    (:second 8)
    (:teenth 13)
    (:third 15)
    (:fourth 22)
    (:last (- (last-day-of-month year month) 6))))

(defun last-day-of-month (year month)
  (let* ((next-month (if (= month 12) 1 (1+ month)))
         (next-year (if (= month 12) (1+ year) year))
         (encoded (encode-date next-year next-month 1)))
    (date-of-universal-time (1- encoded))))

(defun encode-date (year month day)
  (encode-universal-time 0 0 0 day month year))

(defun dow-of-universal-time (utime)
  (nth-value 6 (decode-universal-time utime)))

(defun date-of-universal-time (utime)
  (nth-value 3 (decode-universal-time utime)))
