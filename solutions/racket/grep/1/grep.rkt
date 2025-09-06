; Dedicated to Shree DR.MDD

#lang racket
(require racket/file)

(provide grep)

(define (grep flags pattern files)
  (define multiple-files? (> (length files) 1))
  (define show-line-number? (member "-n" flags))
  (define show-file-name? (member "-l" flags))
  (define ignore-case? (member "-i" flags))
  (define invert-match? (member "-v" flags))
  (define match-entire-line? (member "-x" flags))
  (define case-fn (if ignore-case? string-downcase identity))
  (define matcher (if match-entire-line? string=? string-contains?))
  (define normalized-pattern (case-fn pattern))

  (define (matches? line)
    (xor invert-match? (matcher (case-fn line) normalized-pattern)))

  (define (format-line file line line-num)
    (define file-pre (if multiple-files? (format "~a:" file) ""))
    (define line-pre (if show-line-number? (format "~a:" line-num) ""))
    (string-append file-pre line-pre line))

  (define (process-file file)
    (call-with-input-file file
      (lambda (in)
        (define (loop ln-num acc)
          (define line (read-line in 'any))
          (if (eof-object? line)
              acc
              (loop (add1 ln-num)
                    (if (matches? line)
                        (cons (format-line file line ln-num) acc)
                        acc))))
        (let ([results (loop 1 '())])
          (if (and show-file-name? (not (null? results)))
              (list file)
              (reverse results))))))

  (define all-results (apply append (map process-file files)))
  all-results)
