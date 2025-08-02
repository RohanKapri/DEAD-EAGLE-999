;;; affine-cipher.el --- Affine Cipher (exercism)  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
(defun coprimep (a b)
  "Coprimep retuns true if the only common divisor of A and B is 1."
(let ((results (cl-map 'list (lambda (x) (if (and (eq 0 (mod a x)) (eq 0 (mod b x))) x 0)) (number-sequence 1 (max a b)))))
  (if (eq (apply #'max results) 1) t nil)))

(defun encode (phrase key)
  "Encodes PHRASE using KEY.a."
  (and (not (coprimep (alist-get "a" key nil nil #'equal) 26)) (error "a and m must be coprime."))
  (let ((raw_string (mapconcat (lambda (x) (cond ((and (>= x ?a) (<= x ?z)) (char-to-string (+ ?a (mod (+ (* (alist-get "a" key nil nil #'equal) (- x ?a)) (alist-get "b" key nil nil #'equal)) 26))))
                                                 ((and (>= x ?0) (<= x ?9)) (char-to-string x)))) (downcase phrase) "")))
    (string-trim (replace-regexp-in-string (rx (= 5 (any letter digit))) (lambda (x) (concat x " ")) raw_string))))

(defun mmi (a)
  "mmi returns the modular multiplicative inverse of A and 26."
  (and (not (coprimep a 26)) (error "a and m must be coprime."))
  (let ((result 1))
    (while (not (eq (mod result a) 0))
      (setq result (+ result 26)))
    (/ result a)))

(defun decode (phrase key)
  (let ((phrase_ns (string-replace " " "" phrase))
        (inverse (mmi (alist-get "a" key nil nil #'equal))))
    (mapconcat (lambda (x) (cond ((and (>= x ?a) (<= x ?z)) (char-to-string (+ ?a (mod (* inverse (- (- x ?a) (alist-get "b" key nil nil #'equal))) 26))))
                                 ((and (>= x ?0) (<= x ?9)) (char-to-string x)))) phrase_ns "")))

(provide 'affine-cipher)
;;; affine-cipher.el ends here