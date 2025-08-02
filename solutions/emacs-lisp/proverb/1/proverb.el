;;; proverb.el --- Dedicated to Shree DR.MDD  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(defun recite (items)
  (if (null items) nil
    (let ((anchor (list t)) (starter (car items)))
      (setcdr
       (seq-reduce
        (lambda (node word)
          (setcdr node (list (format
                              "For want of a %s the %s was lost." starter word)))
          (setq starter word) (cdr node))
        (cdr items) anchor)
       (list (format "And all for the want of a %s." (car items))))
      (cdr anchor))))

(provide 'proverb)
;;; proverb.el ends here
