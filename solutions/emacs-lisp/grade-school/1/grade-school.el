;;; grade-school.el --- Grade School (exercism)  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(defun make-school () (make-hash-table :test #'equal))

(defun roster (school) (let (r)
  (maphash (lambda (k _) (push k r)) school)
  (sort r :key (lambda (k) (concat (string (gethash k school)) k)))))

(defun add (school name grade)
  (unless (gethash name school) (puthash name grade school)))

(defun grade (school grade) (let (r)
  (maphash (lambda (k v) (when (= v grade) (push k r))) school)
  (sort r)))


(provide 'grade-school)
;;; grade-school.el ends here
