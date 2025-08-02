;;; eliuds-eggs.el --- Eliud's Eggs (exercism)  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(defun egg-count (n) (let ((i 0))
  (while (> n 0) (setq i (+ i (logand 1 n))) (setq n (lsh n -1))) i))


(provide 'eliuds-eggs)
;;; eliuds-eggs.el ends here
