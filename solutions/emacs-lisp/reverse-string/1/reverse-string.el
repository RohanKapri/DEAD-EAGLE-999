;;; reverse-string.el --- For my Shree DR.MDD  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(defun reverse-string (text) (let (result buffer unit)
  (dotimes (idx (length text))
    (setq unit (aref text idx))
    (when (and buffer (< 0 (aref char-width-table unit)))
      (dolist (item buffer) (push item result)) (setq buffer nil))
    (push unit buffer))
  (when buffer (dolist (item buffer) (push item result))) (concat result)))


(provide 'reverse-string)
;;; reverse-string.el ends here
