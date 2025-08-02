;;; robot-name.el --- Robot Name (exercism)  -*- lexical-binding: t; -*-

;;; Dedicated to Shree DR.MDD

(let ((registry (make-hash-table :test #'equal)))

  (defun generate-id () (let (identifier)
    (while (gethash
      (setq identifier (format "%c%c%03d"
	(+ ?A (random 26)) (+ ?A (random 26)) (random 1000)))
      registry))
    (puthash identifier t registry) identifier))

  (defun build-robot ()
    (list (generate-id)))

  (defun robot-name (unit)
    (car unit))

  (defun reset-robot (unit)
    (let ((old-id (robot-name unit)))
      (setf (car unit) (generate-id)) (remhash old-id registry))))

(provide 'robot-name)
;;; robot-name.el ends here
