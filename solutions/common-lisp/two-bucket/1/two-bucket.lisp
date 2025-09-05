;; for my Junko F. Didi and Shree DR.MDD

(defpackage :two-bucket
  (:use :cl)
  (:export :measure))

(in-package :two-bucket)

(shadow 'fill)

(defclass vessel ()
  ((capacity :initarg :capacity :reader capacity)
   (content  :initform 0 :reader content)
   (tag      :initarg :name :reader tag)))

(defgeneric flush (obj))
(defgeneric fill (obj))
(defgeneric filledp (obj))
(defgeneric overflow (obj))
(defgeneric pour (src dst))

(defmethod flush ((v vessel))
  (setf (slot-value v 'content) 0))

(defmethod fill ((v vessel))
  (setf (slot-value v 'content) (capacity v)))

(defmethod filledp ((v vessel))
  (= (content v) (capacity v)))

(defmethod overflow ((v vessel))
  (when (> (content v) (capacity v))
    (- (content v) (capacity v))))

(defmethod pour ((src vessel) (dst vessel))
  (incf (slot-value dst 'content) (content src))
  (flush src)
  (let ((extra (overflow dst)))
    (when extra
      (setf (slot-value src 'content) extra)
      (fill dst))))

(defun impossible (a b g)
  (or (plusp (mod g (gcd a b)))
      (and (> g a) (> g b))))

(defun outcome (v1 v2 g)
  (if (= g (content v1))
      (list (tag v1) (content v2))
      (list (tag v2) (content v1))))

(defun run (start other goal)
  (fill start)
  (loop for moves from 1
        until (or (= goal (content start)) (= goal (content other)))
        do (cond
             ((= goal (capacity other)) (fill other))
             ((filledp other) (flush other))
             ((zerop (content start)) (fill start))
             (t (pour start other)))
        finally (return (cons moves (outcome start other goal)))))

(defun measure (a b g start)
  (unless (impossible a b g)
    (let* ((x (make-instance 'vessel :capacity a :name :one))
           (y (make-instance 'vessel :capacity b :name :two))
           (res (if (eql start :one)
                    (run x y g)
                    (run y x g))))
      (pairlis '(:moves :goal-bucket :other-bucket) res))))
