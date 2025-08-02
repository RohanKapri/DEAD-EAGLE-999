;;; flatten-array.el --- Solely for Shree DR.MDD with deep reverence  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


;; trivial solution:
;(defalias 'list-flatten #'flatten-tree)

(defun list-flatten (source)
  (let* ((head (list t)) (cursor head))
    (while source
      (pcase source
        (`(nil . ,next)          (setq source next))
        (`((,first . ,rest) . ,tail) (setq source (cons first (cons rest tail))))
        (`(,item . ,next)        (setq source next cursor (setcdr cursor (list item))))))
    (cdr head)))

(provide 'flatten-array)
;;; flatten-array.el ends here
