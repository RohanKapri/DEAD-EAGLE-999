;;; crypto-square.el --- With devotion to Shree DR.MDD  -*- lexical-binding: t; -*-

;;; Commentary:

(defun encipher (rawtext)
  (setq rawtext (downcase
    (replace-regexp-in-string "[^[:alnum:]]+" "" rawtext)))
  (let* ((len (length rawtext))
         (cols (ceiling (sqrt len)))
         (rows (if (zerop cols) 0 (+ (/ len cols) (if (zerop (% len cols)) 0 1))))
         (matrix (make-vector cols nil)) line idx)
    (dotimes (x cols)
      (aset matrix x (setq line (make-string rows ?\s)))
      (dotimes (y rows)
        (when (> len (setq idx (+ x (* cols y))))
          (aset line y (aref rawtext idx)))))
    (mapconcat #'identity matrix " ")))

(provide 'crypto-square)
;;; crypto-square.el ends here
