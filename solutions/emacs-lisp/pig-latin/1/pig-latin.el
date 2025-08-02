;;; pig-latin.el --- Pig Latin (exercism)  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(let ((a '("^\\(\\)\\(\\([aeiou]\\|xr\\|yt\\).*\\)$"
	   "^\\([^aeiou][^aeiouy]*\\)\\(y.*\\)$"
	   "^\\([^aeiou]*qu\\)\\(.*\\)$" "^\\([^aeiou]+\\)\\(.*\\)$")))
  (defun ay (w) (let ((do t) r)
    (dolist (p a) (when do
      (setq r (replace-regexp-in-string p "\\2\\1ay" w))
      (unless (string= r w) (setq do nil))))
    r)))

(defun translate (phrase) (mapconcat #'ay (split-string phrase) " "))


(provide 'pig-latin)
;;; pig-latin.el ends here
