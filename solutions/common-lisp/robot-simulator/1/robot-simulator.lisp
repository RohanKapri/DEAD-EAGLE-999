(in-package #:cl-user)
(defpackage #:robot-simulator
  (:use #:common-lisp)
  (:export #:+north+ #:+east+ #:+south+ #:+west+ #:execute-sequence
           #:robot #:robot-position #:robot-bearing #:make-robot))

(in-package #:robot-simulator)

(defconstant +north+ 'north)
(defconstant +south+ 'south)
(defconstant +east+ 'east)
(defconstant +west+ 'west)

(defstruct robot
  (position '(0 . 0))
  (bearing +north+))

(defun execute-right (robot)
  (setf (robot-bearing robot)
        (ecase (robot-bearing robot)
          (north +east+)
          (east +south+)
          (south +west+)
          (west +north+))))

(defun execute-left (robot)
  (setf (robot-bearing robot) 
        (ecase (robot-bearing robot)
          (north +west+)
          (east +north+)
          (south +east+)
          (west +south+))))

(defun execute-advance (robot)
  (let ((position (robot-position robot)))
    (ecase (robot-bearing robot)
      (north (incf (cdr position)))
      (south (decf (cdr position)))
      (east (incf (car position)))
      (west (decf (car position))))))

(defun execute-movement (robot movement)
  (case movement
    (#\R (execute-right robot))
    (#\L (execute-left robot))
    (#\A (execute-advance robot))))

(defun execute-sequence (robot sequence)
  (loop for c across sequence do (execute-movement robot c)))