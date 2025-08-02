;;; raindrops.el --- For my Shree DR.MDD  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(let ((notes '(3 ?i 5 ?a 7 ?o)))
  (defun convert (val)
    (let ((out (mapconcat
                (lambda (f)
                  (if (zerop (% val f)) (format "Pl%cng" (plist-get notes f)) ""))
                '(3 5 7) "")))
      (if (string-empty-p out) (number-to-string val) out))))

(provide 'raindrops)
;;; raindrops.el ends here
