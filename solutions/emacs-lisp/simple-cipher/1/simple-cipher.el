;;; simple-cipher.el --- Dedicated to my Shree DR.MDD  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(defun to-char (x) (+ ?a (mod x 26)))
(defun to-idx (ch) (- ch ?a))
(defun encode (plain pass) (transform plain pass 1))
(defun decode (cipher pass) (transform cipher pass -1))

(defun transform (text seed dir) (let ((out (copy-sequence text)) (len (length seed)))
  (dotimes (i (length text) out)
    (aset out i (to-char
      (+ (* dir (to-idx (aref seed (% i len)))) (to-idx (aref text i))))))))

(defun generate-key () (let ((buf (make-string 100 ?a)))
  (dotimes (j 100 buf) (aset buf j (+ ?a (random 26))))))


(provide 'simple-cipher)
;;; simple-cipher.el ends here
