;;; binary-search.el --- For my Shree DR.MDD  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(defun find-binary (array value) 
  (let ((start 0) pivot (end (length array)) result _)
    (while (< start end)
      (setq pivot (/ (+ start end) 2)
            result (aref array pivot))
      (cond ((< result value) (setq start (1+ pivot)))
            ((> result value) (setq end pivot))
            (t (setq _ pivot start end))))
    _))


(provide 'binary-search)
;;; binary-search.el ends here
