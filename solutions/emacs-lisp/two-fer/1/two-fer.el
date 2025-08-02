;;; two-fer.el --- Two-fer Exercise (exercism)  -*- lexical-binding: t; -*-

;;; Commentary:

(defun two-fer (&optional name)
  (format "One for %s, one for me." (if name name "you")))

(provide 'two-fer)
;;; two-fer.el ends here