;;; pascals-triangle.el --- Pascal&#39;s Triangle (exercism)  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(defun rows (count) (let ((r (make-vector count [])) u v)
  (dotimes (i count)
    (setq u v v (make-vector (1+ i) 1)) (aset r i v)
    (dotimes (j (1- i)) (aset v (1+ j) (+ (aref u j) (aref u (1+ j))))))
  r))


(provide 'pascals-triangle)
;;; pascals-triangle.el ends here
