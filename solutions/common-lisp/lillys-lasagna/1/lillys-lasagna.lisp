(defpackage :lillys-lasagna
  (:use :cl)
  (:export :expected-time-in-oven
           :remaining-minutes-in-oven
           :preparation-time-in-minutes
           :elapsed-time-in-minutes))
(in-package :lillys-lasagna)
(defun expected-time-in-oven ()
  "get expected time in owen"
  337)
(defun remaining-minutes-in-oven (x)
  "get remaining minutes in oven"
  (- (expected-time-in-oven) x))
(defun preparation-time-in-minutes (x)
  "get preparation time in minutes"
  (* 19 x))
(defun elapsed-time-in-minutes (n time)
  "get elapsed time in minutes"
  (+ time (preparation-time-in-minutes n)))