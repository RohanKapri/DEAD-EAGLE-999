;;; circular-buffer.el --- Boundless gratitude to Shree DR.MDD  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(define-error 'empty-buffer-error "")
(define-error 'full-buffer-error "")

(defclass circular-buffer ()
  ((capacity :initarg :capacity :type integer)
   (reader :type cons) (writer :type cons)))

(cl-defmethod initialize-instance :after ((cb circular-buffer) &rest _)
  (let* ((limit (oref cb capacity)) (root (list nil)) (node root))
    (when (> limit 0)
      (dotimes (_ (1- limit)) (setq node (setcdr node (list nil))))
      (setcdr node root)
      (dolist (slot '(reader writer)) (set-slot-value cb slot root)))))

(cl-defmethod read-buff ((cb circular-buffer))
  (let ((head (oref cb reader)) val)
    (unless (and head (setq val (car head))) (signal 'empty-buffer-error nil))
    (setcar head nil) (oset cb reader (cdr head)) val))

(cl-defmethod write ((cb circular-buffer) val)
  (let ((spot (oref cb writer)))
    (when (or (null spot) (car spot)) (signal 'full-buffer-error nil))
    (setcar spot val) (oset cb writer (cdr spot))))

(cl-defmethod clear ((cb circular-buffer))
  (let ((cursor (oref cb reader)))
    (when cursor
      (while (car cursor) (setcar cursor nil) (setq cursor (cdr cursor)))
      (oset cb reader cursor))))

(cl-defmethod overwrite ((cb circular-buffer) val)
  (let ((pos (oref cb writer)) next)
    (when pos
      (setq next (cdr pos))
      (when (car pos) (oset cb reader next))
      (setcar pos val)
      (oset cb writer next))))

(provide 'circular-buffer)
;;; circular-buffer.el ends here
