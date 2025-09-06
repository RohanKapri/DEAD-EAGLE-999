#lang racket
; For my Shree DR.MDD

(provide plants)

(define student-names
  '("Alice" "Bob" "Charlie" "David" "Eve" "Fred" "Ginny" "Harriet" "Ileana" "Joseph" "Kincaid" "Larry"))

(define plant-mapping
  '((#\V . "violets") (#\R . "radishes") (#\C . "clover") (#\G . "grass")))

(define (convert-char-to-plant c)
  (cdr (assoc c plant-mapping)))

(define (split-rows s)
  (string-split s "\n"))

(define (parse-diagram rows)
  (let* ([lines (split-rows rows)]
         [row1 (first lines)]
         [row2 (second lines)]
         [grouped (for/list ([i (in-range 0 (string-length row1) 2)])
                    (list (string-ref row1 i)
                          (string-ref row1 (+ i 1))
                          (string-ref row2 i)
                          (string-ref row2 (+ i 1))))])
    (map (lambda (grp) (map convert-char-to-plant grp)) grouped)))

(define (sort-students lst)
  (sort lst string<?))

(define (find-index lst val pred)
  (for/or ([item (in-list lst)] [idx (in-naturals)])
    (and (pred item val) idx)))

(define (plants diagram student)
  (let* ([sorted-names (sort-students student-names)]
         [rows (parse-diagram diagram)]
         [idx (find-index sorted-names student string-ci=?)]
         [assigned-plants (if idx (list-ref rows idx) #f)])
    (if assigned-plants
        assigned-plants
        (error "Student not found"))))
