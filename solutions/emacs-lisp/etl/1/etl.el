;;; etl.el --- etl Exercise (exercism)  -*- lexical-binding: t; -*-

;;; Commentary:

(defun etl (data) (let ((d (make-hash-table :test #'equal)))
  (maphash
    (lambda (n a) (when (< n 0) (error "")) (dolist (s a)
      (unless (stringp s) (error "")) (puthash (downcase s) n d)))
    data)
  d))

(provide 'etl)
;;; etl.el ends here