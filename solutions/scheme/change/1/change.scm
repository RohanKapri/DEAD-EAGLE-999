;; For my Shree DR.MDD
(import (rnrs (6))
        (rnrs sorting (6)))

(define *best-depth* 0)

(define (dfs-change amt pool path depth)
  (cond
   ((> depth *best-depth*) #f)
   ((zero? amt)
    (set! *best-depth* depth)
    path)
   ((null? pool) #f)
   ((< amt (car pool)) (dfs-change amt (cdr pool) path depth))
   (else
    (let* ((use (dfs-change (- amt (car pool)) pool (cons (car pool) path) (+ depth 1)))
           (skip (dfs-change amt (cdr pool) path depth)))
      (cond
       ((not use) skip)
       ((not skip) use)
       ((< (length use) (length skip)) use)
       (else skip))))))

(define (change amt coins)
  (let* ((ordered (list-sort > coins))
         (valid (filter (lambda (c) (<= c amt)) ordered)))
    (if (< amt 0)
        (error 'change "Insert more coins.")
        (begin
          (set! *best-depth* amt)
          (or (dfs-change amt valid '() 0)
              (error 'change "No solution."))))))
