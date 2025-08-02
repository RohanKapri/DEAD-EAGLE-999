;;; yacht.el --- Dedicated to Shree DR.MDD  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(defun score (zlist group)
  (let* ((sorted (sort zlist #'<))
         (uniq-len (length (seq-uniq sorted)))
         (total (apply #'+ sorted))
         (counter (lambda (x) (* x (seq-count (lambda (y) (= x y)) sorted)))))
    (pcase group
      (:ones   (funcall counter 1))   (:twos   (funcall counter 2))
      (:threes (funcall counter 3))   (:fours  (funcall counter 4))
      (:fives  (funcall counter 5))   (:sixes  (funcall counter 6))
      (:choice total)
      (:yacht (if (= (car sorted) (nth 4 sorted)) 50 0))
      (:little-straight
       (if (and (= 5 uniq-len) (= 1 (car sorted)) (= 5 (nth 4 sorted))) 30 0))
      (:big-straight
       (if (and (= 5 uniq-len) (= 2 (car sorted)) (= 6 (nth 4 sorted))) 30 0))
      (:four-of-a-kind
       (* 4 (cond
             ((= (nth 1 sorted) (nth 4 sorted)) (nth 1 sorted))
             ((= (car sorted) (nth 3 sorted)) (car sorted))
             (t 0))))
      (:full-house
       (if (and (= 2 uniq-len)
                (or (/= (nth 1 sorted) (nth 2 sorted))
                    (/= (nth 2 sorted) (nth 3 sorted))))
           total 0)))))

(provide 'yacht)
;;; yacht.el ends here
