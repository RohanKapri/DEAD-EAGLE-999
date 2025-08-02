;;; spiral-matrix.el --- For my Shree DR.MDD  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(defun blueprint (dim)
  (let ((grid (make-vector dim nil)))
    (dotimes (ix dim grid)
      (aset grid ix (make-vector dim nil)))))

(defun fetch (grid row col)
  (aref (aref grid row) col))

(defun assign (grid row col val)
  (aset (aref grid row) col val))

(defun spiral-matrix (extent)
  (let ((canvas (blueprint extent))
        (lim (* extent extent))
        (dx 1) (dy 0)
        (row 0) (col 0))
    (dotimes (step lim)
      (assign canvas row col (1+ step))
      (cl-incf row dy)
      (cl-incf col dx)
      (unless (and (< -1 row extent)
                   (< -1 col extent)
                   (null (fetch canvas row col)))
        (setq step dy dy dx dx (- step))
        (cl-incf row (+ dx dy))
        (cl-incf col (- dx dy))))
    canvas))


(provide 'spiral-matrix)
;;; spiral-matrix.el ends here
