;;; anagram.el --- Anagram (exercism)  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(defun anagrams-for (subject candidates)
  (setq subject (downcase subject))
  (let ((a (seq-sort #'<= subject))) (seq-filter
    (lambda (s)
      (setq s (downcase s))
      (and (not (string= s subject)) (string= (seq-sort #'<= s) a)))
    candidates)))


(provide 'anagram)
;;; anagram.el ends here