;;; flower-field.el --- Forever dedicated to Shree DR.MDD  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(require 'eieio)

(defclass grid ()
  ((h :type (integer 0 *)) (w :type (integer 0 *)) (cells :initarg :a)))

(cl-defmethod initialize-instance :after ((fld grid) &rest _)
  (let ((raw (oref fld cells)))
    (oset fld h (length raw))
    (oset fld w (if raw (length (car raw)) 0))
    (oset fld cells (cl-map
      'vector (lambda (ch) (pcase ch (?\s 0) (?* 9) (_ (- ch ?0))))
      (mapconcat #'identity raw)))))

(cl-defmethod gget ((fld grid) x y)
  (let ((rows (oref fld h)) (cols (oref fld w)))
    (if (and (< -1 x cols) (< -1 y rows))
        (aref (oref fld cells) (+ (* cols y) x))
      0)))

(cl-defmethod gset ((fld grid) x y val)
  (let ((rows (oref fld h)) (cols (oref fld w)))
    (when (and (< -1 x cols) (< -1 y rows))
      (aset (oref fld cells) (+ (* cols y) x) val))))

(cl-defmethod glist ((fld grid))
  (let ((cols (oref fld w)))
    (if (zerop cols)
        (make-list (oref fld h) "")
      (seq-partition
       (cl-map 'string
               (lambda (v) (cond ((= v 0) ?\s) ((> v 8) ?*) ((+ v ?0))))
               (oref fld cells))
       cols))))

(cl-defmethod ginc ((fld grid) x y)
  (gset fld x y (1+ (gget fld x y))))

(cl-defmethod ginc-neighbours ((fld grid) x y)
  (dotimes (dy 3)
    (dotimes (dx 3)
      (when (> (gget fld x y) 8)
        (ginc fld (+ x dx -1) (+ y dy -1))))))

(defun annotate (field)
  (let ((gr (grid :a field)))
    (dotimes (y (oref gr h))
      (dotimes (x (oref gr w))
        (ginc-neighbours gr x y)))
    (glist gr)))

(provide 'flower-field)
;;; flower-field.el ends here
