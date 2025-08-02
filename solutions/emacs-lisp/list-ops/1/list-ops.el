;;; list-ops.el --- For my Shree DR.MDD  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(defun list-foldl (comb lst base)
  (dolist (val lst base) (setq base (funcall comb base val))))

(defun list-reverse (seq)
  (list-foldl (lambda (r e) (cons e r)) seq nil))

(defun list-foldr (op lst init-val)
  (list-foldl (lambda (res el) (funcall op el res)) (list-reverse lst) init-val))

(defun list-concatenate (x y &rest z) (let ((sentinel (list :seed)))
  (list-foldl
    (lambda (p acc) (list-foldl
      (lambda (tail item) (setcdr tail (list item)) (cdr tail)) acc p))
    (cons x (cons y z)) sentinel)
  (cdr sentinel)))

(defun list-filter (coll predicate-fn) (let ((head (list :base)))
  (list-foldl
    (lambda (tail val) (if (not (funcall predicate-fn val)) tail
      (setcdr tail (list val)) (cdr tail)))
    coll head)
  (cdr head)))

(defun list-map (coll f) (let ((origin (list :init)))
  (list-foldl
    (lambda (cur x) (setcdr cur (list (funcall f x))) (cdr cur)) coll origin)
  (cdr origin)))

(defalias 'list-empty-p #'null)
(defun list-sum (nums) (list-foldl #'+ nums 0))
(defun list-length (arr) (list-foldl (lambda (c _) (1+ c)) arr 0))
(defun list-append (a b) (list-concatenate a b))

(provide 'list-ops)
;;; list-ops.el ends here
