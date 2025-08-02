;;; robot-simulator.el --- robot-simulator (exercism)  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(defun create-robot (x y direction) (record 'robot x y direction))

(let ((a '[south west north east]))
  (defun move (robot instructions)
    (mapc (lambda (c) (let ((x (aref robot 1)) (y (aref robot 2))
			    (i (seq-position a (aref robot 3))))
	    (pcase c
	      (?L (setf (aref robot 3) (aref a (mod (1- i) 4))))
	      (?R (setf (aref robot 3) (aref a (mod (1+ i) 4))))
	      (?A (if (zerop (% i 2)) (setf (aref robot 2) (+ y i -1))
		    (setf (aref robot 1) (+ x i -2)))))))
	  instructions)
    robot))


(provide 'robot-simulator)
;;; robot-simulator.el ends here