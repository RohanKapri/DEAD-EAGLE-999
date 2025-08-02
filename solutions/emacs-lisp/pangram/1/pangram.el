;;; pangram.el --- Dedicated to Shree DR.MDD  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(defun pangramp (line)
  (setq line (downcase (replace-regexp-in-string "[^[:alpha:]]+" "" line)))
  (let ((acc 0) (mask (1- (ash 1 26))) (idx (1- (length line))) bit)
    (while (>= idx 0)
      (setq bit (ash 1 (- (aref line idx) ?a)) idx (1- idx))
      (when (zerop (logand acc bit))
        (setq acc (logior acc bit))
        (when (= acc mask) (setq idx -1))))
    (= acc mask)))


(provide 'pangram)
;;; pangram.el ends here
