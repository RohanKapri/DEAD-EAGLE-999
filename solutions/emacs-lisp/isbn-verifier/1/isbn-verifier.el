;;; isbn-verifier.el --- ISBN Verifier (exercism)  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(defun validp (isbn)
  (setq isbn (replace-regexp-in-string "-+" "" isbn))
  (when (string-match-p "^[0-9]\\{9\\}[0-9X]$" isbn)
    (let (c) (zerop (seq-reduce
      (lambda (a i) (setq c (aref isbn i))
		    (% (+ a (* (- 10 i) (if (= c ?X) 10 (- c ?0)))) 11))
      (number-sequence 0 (1- (length isbn))) 0)))))


(provide 'isbn-verifier)
;;; isbn-verifier.el ends here