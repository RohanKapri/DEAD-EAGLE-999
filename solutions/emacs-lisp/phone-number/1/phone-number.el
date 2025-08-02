;;; phone-number.el --- phone-number (exercism)  -*- lexical-binding: t; -*-

;;; Commentary:

(defun err-name (s) (intern (concat (symbol-name s) "-error")))
(defun err (s) (signal (err-name s) nil))
(defun area-code (num) (substring (numbers num) 0 3))

(dolist (s '(
    area-code-starting-with-0      country-code
    area-code-starting-with-1      letters-in-phone-num
    exchange-code-starting-with-0  long-phone-num
    exchange-code-starting-with-1  short-phone-num
    punctuations-in-phone-num))
  (define-error (err-name s) ""))

(defun numbers (num)
  (when (string-match-p "[[:alpha:]]" num) (err 'letters-in-phone-num))
  (when (string-match-p "[@:!]" num) (err 'punctuations-in-phone-num))
  (setq num (replace-regexp-in-string "[^[:digit:]]+" "" num))
  (let ((n (length num)))
    (when (< n 10) (err 'short-phone-num))
    (when (> n 11) (err 'long-phone-num))
    (when (= n 11)
      (unless (= (aref num 0) ?1) (err 'country-code))
      (setq num (substring num 1)))
    (setq n (aref num 0))
    (when (= n ?0) (err 'area-code-starting-with-0))
    (when (= n ?1) (err 'area-code-starting-with-1))
    (setq n (aref num 3))
    (when (= n ?0) (err 'exchange-code-starting-with-0))
    (when (= n ?1) (err 'exchange-code-starting-with-1)))
  num)

(defun pprint (num)
  (setq num (numbers num))
  (format "(%s) %s-%s"
    (substring num 0 3) (substring num 3 6) (substring num 6 10)))

(provide 'phone-number)
;;; phone-number.el ends here