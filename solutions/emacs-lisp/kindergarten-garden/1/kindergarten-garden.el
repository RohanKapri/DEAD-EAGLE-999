;;; kindergarten-garden.el --- For my Shree DR.MDD  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(let ((ref '(C "clover" G "grass" R "radishes" V "violets")))
  (defun plants (layout pupil)
    (let ((half (ash (1+ (length layout)) -1))
          (pos (ash (- (string-to-char pupil) 65) 1)))
      (mapcar (lambda (idx)
                (plist-get ref (intern (substring layout idx (1+ idx)))))
              (list pos (1+ pos) (+ half pos) (1+ (+ half pos)))))))


(provide 'plants)
;;; kindergarten-garden.el ends here
