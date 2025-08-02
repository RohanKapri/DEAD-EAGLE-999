;;; diamond.el --- Diamond (exercism)  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(defun sp (n) (make-string n ?\s))

(defun rows (letter)
  (let* ((n (- letter ?A)) (s (sp n)) (c (string ?A))
	 (a (make-vector (1+ (* n 2)) "")) j)
    (aset a 0 (concat s c s))
    (dotimes (i n)
      (setq j (1+ i) s (sp (- n j)) c (string (+ ?A j)))
      (aset a j (concat s c (sp (1+ (* i 2))) c s))
      (aset a (- (* n 2) i) (aref a i)))
    a))


(provide 'diamond)
;;; diamond.el ends here
