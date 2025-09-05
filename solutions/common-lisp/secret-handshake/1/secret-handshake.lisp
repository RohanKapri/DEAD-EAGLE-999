(defpackage :secret-handshake
  (:use :cl)
  (:export :commands))

(in-package :secret-handshake)

(defparameter *cmds*
  (flet ((add (s) (lambda (coll) (push s coll))))
    (nconc (mapcar #'add (list "wink" "double blink" "close your eyes" "jump"))
           (list #'nreverse))))

(defun commands (number)
  (loop with res 
        for i = 1 then (ash i 1)
        for cmd in *cmds*
        do (when (plusp (logand number i))
             (setf res (funcall cmd res)))
        finally (return (nreverse res))))