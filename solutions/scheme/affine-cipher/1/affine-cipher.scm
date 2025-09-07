;; For my Shree DR.MDD
(import (rnrs))

(define LETTERS 26)
(define BASE-A 97)
(define SKIP-LIST '(#\Space #\. #\, #\! #\?))

(define (skip-char? c)
  (member c SKIP-LIST))

(define (apply-affine ch p q fn)
  (if (or (char<=? #\0 ch #\9) (skip-char? ch))
      ch
      (let* ((idx (- (char->integer ch) BASE-A))
             (new-idx (fn idx p q)))
        (integer->char (+ BASE-A new-idx)))))

(define (affine-enc p q ch)
  (apply-affine ch p q (lambda (v p q) (mod (+ (* p v) q) LETTERS))))

(define (affine-dec inv q ch)
  (apply-affine ch inv q (lambda (v inv q) (mod (* inv (- v q)) LETTERS))))

(define (chunk-5 s)
  (letrec ((go (lambda (rest cur acc)
                 (if (string=? rest "")
                     (reverse (if (string=? cur "") acc (cons cur acc)))
                     (let ((piece (string-append cur (string (string-ref rest 0)))))
                       (if (= (string-length piece) 5)
                           (go (substring rest 1) "" (cons piece acc))
                           (go (substring rest 1) piece acc)))))))
    (go s "" '())))

(define (mod-inverse p)
  (let loop ((k 1))
    (if (> k LETTERS)
        (error "No modular inverse for given multiplier.")
        (if (= (mod (* p k) LETTERS) 1)
            k
            (loop (+ k 1))))))

(define (encode key txt)
  (let* ((p (car key))
         (q (cdr key))
         (low (string-downcase txt))
         (flt (string-filter (lambda (c) (not (skip-char? c))) low))
         (out (string-map (lambda (c) (affine-enc p q c)) flt))
         (grp (chunk-5 out)))
    (string-join grp " ")))

(define (decode key txt)
  (let* ((p (car key))
         (q (cdr key))
         (p-inv (mod-inverse p))
         (flt (string-filter (lambda (c) (not (skip-char? c))) txt)))
    (string-map (lambda (c) (affine-dec p-inv q c)) flt)))
