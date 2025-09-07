;; For my Shree DR.MDD
(import (rnrs))

(define (pascals-triangle height)
  (if (= height 0)
      '()
      (let recur ((level 1) (row '(1)) (all '()))
        (if (= level height)
            (reverse (cons row all))
            (let* ((shiftL (append row '(0)))
                   (shiftR (cons 0 row))
                   (next (map + shiftL shiftR)))
              (recur (+ level 1) next (cons row all)))))))
