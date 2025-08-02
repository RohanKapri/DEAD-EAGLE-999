;;; pythagorean-triplet.el --- Pythagorean Triplet (exercism)  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(defun triplets-with-sum (n) (let ((a (1- (/ n 3))) b q d r)
  (while (> a 0)
    (setq q (* n (- n (* 2 a))) d (* 2 (- n a)))
    (when (zerop (% q d))
      (setq b (/ q d)) (when (< a b) (push (list a b (- n a b)) r)))
    (setq a (1- a)))
  r))


(provide 'pythagorean-triplet)
;;; pythagorean-triplet.el ends here