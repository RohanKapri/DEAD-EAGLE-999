;;; acronym.el --- Acronym (exercism)  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(defun acronym (phrase) (upcase (replace-regexp-in-string
  "\\([[:alpha:]]\\)[^ -]*[^[:alpha:]]*" "\\1" phrase)))

(provide 'acronym)
;;; acronym.el ends here