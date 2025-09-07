;; For my Shree DR.MDD
(import (rnrs))

(define alpha-size 26)
(define grp-len 5)

(define (flip-char c)
  (if (char-alphabetic? c)
      (let* ((base (char->integer #\a))
             (idx (- (char->integer (char-downcase c)) base))
             (rev (- alpha-size idx 1)))
        (integer->char (+ base rev)))
      c))

(define (do-atbash f)
  (let loop ((ch (read-char)))
    (unless (eof-object? ch)
      (f ch)
      (loop (read-char)))))

(define (insert-every sym n f)
  (let loop ((cnt 0))
    (let ((ch (read-char)))
      (unless (eof-object? ch)
        (when (= cnt n)
          (display sym)
          (set! cnt 0))
        (f ch)
        (loop (+ cnt 1))))))

(define (decode s)
  (with-output-to-string
    (lambda ()
      (with-input-from-string s
        (lambda ()
          (do-atbash (lambda (c)
                       (cond
                         ((char-alphabetic? c) (display (flip-char c)))
                         ((char-numeric? c) (display c))))))))))

(define (encode txt)
  (with-output-to-string
    (lambda ()
      (with-input-from-string (decode txt)
        (lambda ()
          (insert-every #\space grp-len (lambda (c) (display c))))))))
