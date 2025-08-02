;;; resistor-color-trio.el --- For my Shree DR.MDD  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(let ((tone '["black" "brown" "red" "orange" "yellow"
              "green" "blue" "violet" "grey" "white"])
      (scale '["" "kilo" "mega" "giga"]))
  (defun label (bands)
    (let ((val (* (+ (* 10 (seq-position tone (car bands)))
                     (seq-position tone (cadr bands)))
                  (expt 10 (seq-position tone (caddr bands))) 1.0))
          (unit 0))
      (while (>= val 1000) (setq val (/ val 1000) unit (1+ unit)))
      (format "%g %sohms" val (aref scale unit)))))

(provide 'resistor-color-trio)
;;; resistor-color-trio.el ends here
