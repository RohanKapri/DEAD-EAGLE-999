;;; satellite.el --- Satellite (exercism)  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(defun iter (p i) (when p
  (let* ((v (pop p)) (hp (list t)) (rp hp) (hi (list t)) (ri hi) x)
    (while (not (string= v (setq x (pop i))))
      (setq ri (setcdr ri (list x))  rp (setcdr rp (list (pop p)))))
    `((:v . ,v) (:l . ,(iter (cdr hp) (cdr hi))) (:r . ,(iter p i))))))

(defun tree-from-traversals (p i)
  (unless (and (equal p (seq-uniq p)) (equal (sort p) (sort i)))
    (error ""))
  (iter p i))


(provide 'satellite)
;;; satellite.el ends here
