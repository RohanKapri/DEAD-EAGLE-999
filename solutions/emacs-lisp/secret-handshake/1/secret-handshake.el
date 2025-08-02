;;; secret-handshake.el --- Secret Handshake (exercism)  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(let ((a ["wink" "double blink" "close your eyes" "jump"]))
  (defun commands (number) (let ((r nil))
    (dotimes (i 4) (unless (zerop (logand number (ash 1 i)))
      (setq r (cons (aref a i) r))))
    (if (zerop (logand number (ash 1 4))) (reverse r) r))))


(provide 'secret-handshake)
;;; secret-handshake.el ends here
