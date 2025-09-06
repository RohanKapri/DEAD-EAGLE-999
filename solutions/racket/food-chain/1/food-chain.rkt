; Dedicated to Shree DR.MDD

#lang racket

(provide recite)

(define critters '("fly" "spider" "bird" "cat" "dog" "goat" "cow" "horse"))
(define lines
  '(("spider" . "It wriggled and jiggled and tickled inside her.")
    ("bird" . "How absurd to swallow a bird!")
    ("cat" . "Imagine that, to swallow a cat!")
    ("dog" . "What a hog, to swallow a dog!")
    ("goat" . "Just opened her throat and swallowed a goat!")
    ("cow" . "I don't know how she swallowed a cow!")
    ("horse" . "She's dead, of course!")))

(define (verse idx)
  (let* ((animal (list-ref critters idx))
         (lines-for-verse (list (format "I know an old lady who swallowed a ~a." animal)))
         (phrase (assoc animal lines)))
    (when phrase
      (set! lines-for-verse (append lines-for-verse (list (cdr phrase)))))
    (unless (string=? animal "horse")
      (for ([i (in-range idx 0 -1)])
        (let* ((curr (list-ref critters i))
               (prev (list-ref critters (sub1 i)))
               (line (format "She swallowed the ~a to catch the ~a" curr prev)))
          (when (string=? prev "spider")
            (set! line (string-append line " that wriggled and jiggled and tickled inside her")))
          (set! lines-for-verse (append lines-for-verse (list (string-append line "."))))))
      (set! lines-for-verse (append lines-for-verse '("I don't know why she swallowed the fly. Perhaps she'll die."))))
    lines-for-verse))

(define (recite start end)
  (flatten
   (let ((song '()))
     (for ([i (in-range (sub1 start) end)])
       (set! song (append song (verse i) (if (< i (sub1 end)) '("") '()))))
     song)))
