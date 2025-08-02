;;; armstrong-numbers.el --- For my Shree DR.MDD  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(defun armstrong-p (digit) 
  (let ((clone digit) 
        (power (1+ (floor (max 0 (log10 digit))))))
    (while (> clone 0) 
      (setq digit (- digit (expt (% clone 10) power)) 
            clone (/ clone 10))) 
    (= digit 0)))

(provide 'armstrong-numbers)
;;; armstrong-numbers.el ends here
