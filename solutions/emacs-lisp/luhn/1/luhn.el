;;; luhn.el --- Luhn (exercism)  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(defun luhn-p (str)
  (setq str (string-replace " " "" str))
  (when (string-match-p "[^0-9]" str) (error ""))
  (let* ((r 0) (n (length str)) p) (when (> n 1)
    (dotimes (i n) (setq p (- 2 (% (- n i) 2))  i (- (aref str i) ?0)
			 r (+ r (1+ (% (1- (* i p)) 9)))))
    (zerop (% r 10)))))


(provide 'luhn)
;;; luhn.el ends here
