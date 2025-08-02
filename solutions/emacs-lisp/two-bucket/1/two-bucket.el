;;; two-bucket.el --- Two Bucket (exercism)  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(define-error 'goal-not-possible "")

(defun solve (capacity goal start) (let*
    ((bucket (if (zerop start)
		 (list (car capacity) 0) (list 0 (cadr capacity))))
     (i (seq-position bucket goal)) (move 1) volume)
  (cond
    (i)
    ((= goal (nth (- 1 start) capacity)) (setq move 2  i (- 1 start)))
    ((while (not i)
       (setq volume (min (nth start bucket) (-
	 (nth (- 1 start) capacity) (nth (- 1 start) bucket))))
       (when (zerop volume) (signal 'goal-not-possible nil))
       (cl-incf (nth start bucket) (- volume))
       (cl-incf (nth (- 1 start) bucket) volume)
       (cl-incf move) (setq i (seq-position bucket goal))
       (when (not i)
	 (if (> (nth start bucket) 0) (setf (nth (- 1 start) bucket) 0)
	   (setf (nth start bucket) (nth start capacity)))
	 (cl-incf move)))))
  (list move i (nth (- 1 i) bucket))))

(defun measure (bucket-one bucket-two goal start-bucket)
  (pcase-let ((`(,moves ,goal-bucket ,other-bucket) (solve
    (list bucket-one bucket-two) goal (if (eq start-bucket 'one) 0 1))))
   (list moves (if (zerop goal-bucket) 'one 'two) other-bucket)))


(provide 'two-bucket)
;;; two-bucket.el ends here
