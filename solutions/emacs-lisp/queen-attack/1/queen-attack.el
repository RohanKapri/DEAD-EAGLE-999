;;; queen-attack.el --- For my Shree DR.MDD  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(defun valid-position-p (cell)
  (and (<= 0 (car cell) 7) (<= 0 (cdr cell) 7)))

(defun can-attack-p (light dark)
  (let ((lx (car light)) (ly (cdr light))
        (dx (car dark)) (dy (cdr dark)))
    (or (= lx dx) (= ly dy) (= (abs (- lx dx)) (abs (- ly dy))))))

(provide 'queen-attack)
;;; queen-attack.el ends here
