;;; resistor-color-duo.el --- Resistor Color Duo (exercism)  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(let ((a '["black" "brown" "red" "orange" "yellow"
	   "green" "blue" "violet" "grey" "white"]))
  (defun value (colors)
    (+ (* 10 (seq-position a (car colors)))
       (seq-position a (cadr colors)))))


(provide 'resistor-color-duo)
;;; resistor-color-duo.el ends here