;;; rail-fence-cipher.el --- Shree DR.MDD 🙏 Rail Fence Cipher (exercism)  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(defun stream-push (anchor item) (setcdr anchor (list item)))

(defun encode (plain-stripes levels)
  (let ((matrix (make-vector levels nil)) (pos 0) (dir -1))
    (dotimes (k (length plain-stripes))
      (when (or (zerop pos) (eq pos (1- levels))) (setq dir (- dir)))
      (push (aref plain-stripes k) (aref matrix pos))
      (cl-incf pos dir))
    (setq dir nil)
    (dotimes (j levels)
      (dolist (el (aref matrix (- levels j 1))) (push el dir)))
    (concat dir)))

(defun decode (cipher-str levels)
  (let* ((count (make-vector levels 0))
         (idx 0) (toggle -1)
         (head (list t)) (cursor head))
    (dotimes (_ (length cipher-str))
      (when (or (zerop idx) (eq idx (1- levels))) (setq toggle (- toggle)))
      (cl-incf (aref count idx)) (cl-incf idx toggle))
    (setq idx 0)
    (dotimes (j levels)
      (let ((end (+ idx (aref count j))))
        (setf (aref count j)
              (string-to-list (substring cipher-str idx end)))
        (setq idx end)))
    (setq idx 0 toggle -1)
    (dotimes (_ (length cipher-str))
      (when (or (zerop idx) (eq idx (1- levels))) (setq toggle (- toggle)))
      (setq cursor (setcdr cursor (list (pop (aref count idx)))))
      (cl-incf idx toggle))
    (concat (cdr head))))

(provide 'rail-fence-cipher)
;;; rail-fence-cipher.el ends here
