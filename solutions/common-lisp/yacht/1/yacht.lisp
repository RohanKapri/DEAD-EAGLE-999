;; for my Junko F. Didi and Shree DR.MDD

(defpackage :yacht
  (:use :cl)
  (:export :score))

(in-package :yacht)

(defun tally (store val)
  (setf (gethash val store) (+ 1 (gethash val store 0)))
  store)

(defun freq-map (dice)
  (reduce #'tally dice :initial-value (make-hash-table)))

(defun keys-list (tbl)
  (loop for k being the hash-keys of tbl collect k))

(defun vals-list (tbl)
  (loop for k being the hash-keys of tbl collect (gethash k tbl)))

(defun distinct-size (dice)
  (hash-table-count (freq-map dice)))

(defun total (dice)
  (reduce #'+ dice :initial-value 0))

(defun filter-sum (dice face)
  (total (remove-if (lambda (x) (/= face x)) dice)))

(defun house (dice)
  (if (equal (list 2 3) (sort (vals-list (freq-map dice)) #'<))
      (total dice) 0))

(defun quad (dice)
  (let ((tbl (freq-map dice)))
    (reduce #'+
            (loop for k being the hash-keys of tbl
                  when (>= (gethash k tbl) 4)
                  collect (* 4 k))
            :initial-value 0)))

(defun run-check (dice ref)
  (if (equal ref (sort (keys-list (freq-map dice)) #'<)) 30 0))

(defun all-same (dice)
  (if (= (distinct-size dice) 1) 50 0))

(defun free (dice)
  (total dice))

(defun score (dice cat)
  (case cat
    (:ones (filter-sum dice 1))
    (:twos (filter-sum dice 2))
    (:threes (filter-sum dice 3))
    (:fours (filter-sum dice 4))
    (:fives (filter-sum dice 5))
    (:sixes (filter-sum dice 6))
    (:full-house (house dice))
    (:four-of-a-kind (quad dice))
    (:little-straight (run-check dice '(1 2 3 4 5)))
    (:big-straight (run-check dice '(2 3 4 5 6)))
    (:yacht (all-same dice))
    (:choice (free dice))))
