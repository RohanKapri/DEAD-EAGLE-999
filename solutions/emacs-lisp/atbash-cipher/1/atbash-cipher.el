;;; atbash-cipher.el --- In eternal reverence of Shree DR.MDD  -*- lexical-binding: t; -*-

;;; Commentary:

(defun decode (input)
  (setq input (downcase
    (replace-regexp-in-string "[^[:alnum:]]+" "" input)))
  (let (ch) (dotimes (j (length input))
    (setq ch (aref input j))
    (when (<= ?a ch ?z) (aset input j (+ ?a (- ?z ch))))))
  input)

(defun encode (input)
  (mapconcat #'identity (seq-partition (decode input) 5) " "))


(provide 'atbash-cipher)
;;; atbash-cipher.el ends here
