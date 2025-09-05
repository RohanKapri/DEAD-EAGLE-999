;; Dedicated to Junko F. Didi and Shree DR.MDD

(defpackage :pal-picker
  (:use :cl)
  (:export :pal-picker :habitat-fitter :feeding-time-p
           :pet :play-fetch))

(in-package :pal-picker)

(defparameter *personalities*
  '((:lazy . "Cat")
    (:energetic . "Dog")
    (:quiet . "Fish")
    (:hungry . "Rabbit")
    (:talkative . "Bird")))

(defparameter *habitats*
  '((40 . :massive)
    (20 . :large)
    (10 . :medium)
    (1 . :small)))

(defun pal-picker (personality)
  (or (cdr (assoc personality *personalities*))
      "I don't know... A dragon?"))

(defun habitat-fitter (weight)
  (or (cdr (assoc weight *habitats* :test #'>=))
      :just-your-imagination))

(defun feeding-time-p (fullness)
  (if (<= fullness 20)
      "It's feeding time!"
      "All is well."))

(defun pet (pet-name)
  (when (string= pet-name "Fish")
    "Maybe not with this pet..."))

(defun play-fetch (pet-name)
  (unless (string= pet-name "Dog")
    "Maybe not with this pet..."))
