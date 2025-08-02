;;; word-count.el --- word-count Exercise (exercism)  -*- lexical-binding: t; -*-

;;; Commentary:

(defun word-count (s) (let ((d (make-hash-table :test #'equal)) a)
  (dolist (w (split-string (downcase s) "[^[:alnum:]']+" t))
    (setq w (replace-regexp-in-string "^'+\\|'+$" "" w))
    (puthash w (1+ (gethash w d 0)) d))
  (maphash (lambda (k v) (push (cons k v) a)) d) a))

(provide 'word-count)
;;; word-count.el ends here