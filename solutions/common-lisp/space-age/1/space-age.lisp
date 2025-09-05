(defpackage :space-age
  (:use :cl)
  (:export :on-mercury
           :on-venus
           :on-earth
           :on-mars
           :on-jupiter
           :on-saturn
           :on-uranus
           :on-neptune))

(in-package :space-age)
(defun helper (seconds n) (/ (truncate (+ (* (/ seconds (* 31557600 n)) 100) 0.5)) 100))
(defun on-mercury (n) (helper n 0.2408467))
(defun on-venus (n) (helper n 0.61519726))
(defun on-earth (n) (helper n 1))
(defun on-mars (n) (helper n 1.8808158))
(defun on-jupiter (n) (helper n 11.862615))
(defun on-saturn (n) (helper n 29.447498))
(defun on-uranus (n) (helper n 84.016846))
(defun on-neptune (n) (helper n 164.7913))