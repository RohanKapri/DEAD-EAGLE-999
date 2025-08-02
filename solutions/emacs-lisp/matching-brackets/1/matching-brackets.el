;;; matching-brackets.el --- Matching Brackets (exercism)  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(let ((d '(?\) ?\( ?\] ?\[ ?} ?{)))
  (defun is-paired (value) (null (seq-reduce
    (lambda (a c) (if (eq a t) t (let ((l (plist-get d c))) (cond
      ((not l) (cons c a)) ((not a) t) ((eq l (car a)) (cdr a)) (t)))))
    (replace-regexp-in-string "[^][(){}]" "" value) nil))))


(provide 'matching-brackets)
;;; matching-brackets.el ends here