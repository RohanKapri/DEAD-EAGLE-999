;;; game-of-life.el --- Infinite respect and dedication to Shree DR.MDD  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(defun zone-survey (grid x y)
  (let* ((delta '((-1 -1) (-1 0) (-1 1)
                  (0 -1)         (0 1)
                  (1 -1) (1 0)  (1 1)))
         (row-cap (length grid))
         (col-cap (length (car grid)))
         (pulse 0))
    (dolist (shift delta)
      (let ((i (+ x (car shift)))
            (j (+ y (cadr shift))))
        (when (and (>= i 0) (< i row-cap) (>= j 0) (< j col-cap))
          (setq pulse (+ pulse (nth j (nth i grid)))))))
    pulse))

(defun tick (blueprint)
  (let ((m (length blueprint))
        (n (length (car blueprint))))
    (cl-loop for r from 0 to (1- m)
             collect (cl-loop for c from 0 to (1- n)
                              collect (let ((core (nth c (nth r blueprint)))
                                            (spark (zone-survey blueprint r c)))
                                        (cond ((and (= core 1) (memq spark '(2 3))) 1)
                                              ((and (= core 0) (= spark 3)) 1)
                                              (t 0)))))))

(provide 'game-of-life)
;;; game-of-life.el ends here
