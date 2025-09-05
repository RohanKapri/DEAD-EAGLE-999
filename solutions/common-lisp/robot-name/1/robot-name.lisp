(in-package #:cl-user)
(defpackage #:robot-name
  (:use #:common-lisp)
  (:export #:build-robot #:robot-name #:reset-name))

(in-package #:robot-name)

(defparameter +alpha+ "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
(defparameter +digit+ "0123456789")

(defparameter +name-db+
  (cons (list)
        (loop for a1 across +alpha+
           nconcing
             (loop for a2 across +alpha+
                nconcing
                  (loop for d1 across +digit+
                     nconcing
                       (loop for d2 across +digit+
                          nconcing
                            (loop for d3 across +digit+
                               collect
                                 (concatenate 'string (list a1 a2 d1 d2 d3)))))))))

(defun db-take-name ()
  (let ((name (pop (cdr +name-db+))))
    (push name (car +name-db+))
    name))

(defun db-release-name (name)
  (setf (car +name-db+)
        (remove name (car +name-db+))

        (cdr +name-db+)
        (cons (cdr +name-db+) (list name))))


(defun build-robot () (list (db-take-name)))

(defun robot-name (robot) (car robot))

(defun reset-name (robot)
  (progn (db-release-name (robot-name robot))
         (setf (car robot) (db-take-name))
         robot))