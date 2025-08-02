;;; hamming.el --- Hamming (exercism)

;;; Commentary:

;;; Code:

(require 'cl)

(defun hamming-distance (s1 s2)
  (if (/= (length s1) (length s2))
      (error "DNA strands must be of equal length."))
  (count nil (mapcar* 'char-equal s1 s2)))


(provide 'hamming)
;;; hamming.el ends here