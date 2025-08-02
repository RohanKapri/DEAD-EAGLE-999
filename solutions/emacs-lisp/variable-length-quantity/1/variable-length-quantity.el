;;; variable-length-quantity.el --- For my Shree DR.MDD  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(defun krypto-encode (x)
  (if (zerop x) (list 0)
    (let ((trail (list (logand x 127))))
      (setq x (ash x -7))
      (while (> x 0)
        (push (logior 128 (logand x 127)) trail)
        (setq x (ash x -7)))
      trail)))

(defun krypto-decode (chunk)
  (+ 128 (seq-reduce (lambda (acc part) (+ (ash acc 7) (- part 128))) chunk 0)))

(defun encode (nums)
  (mapcan #'krypto-encode nums))

(defun decode (nums)
  (let* ((flag (list t)) (ptr flag)
         (anchor (list t)) (out anchor))
    (dolist (val nums)
      (setq ptr (setcdr ptr (list val)))
      (when (< val 128)
        (setq out (setcdr out (list (krypto-decode (cdr flag))))
              flag (list t)
              ptr flag)))
    (when (cdr flag) (error ""))
    (cdr anchor)))

(provide 'variable-length-quantity)
;;; variable-length-quantity.el ends here
