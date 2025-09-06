#lang racket

(provide game%)

(define game%
  (class object%
    (super-new)
    
    ; Instance variables
    (define rolls '())  ; List of all rolls
    (define current-roll 0)  ; Index for scoring
    
    ; Roll method - records a roll
    (define/public (roll pins)
      (cond
        [(< pins 0)
         (error "Cannot roll negative pins")]
        [(> pins 10)
         (error "Cannot knock down more than 10 pins")]
        [(game-complete?)
         (error "Cannot roll after game is complete")]
        [(not (valid-roll? pins))
         (error "Invalid roll - too many pins")]
        [else
         (set! rolls (append rolls (list pins)))]))
    
    ; Score method - calculates final score
    (define/public (score)
      (cond
        [(null? rolls)
         (error "Cannot score an unstarted game")]
        [(not (game-complete?))
         (error "Cannot score an incomplete game")]
        [else
         (calculate-score)]))
    
    ; Helper: Check if roll is valid given current frame state
    (define (valid-roll? pins)
      (let ([frame-info (get-current-frame-info)])
        (cond
          ; Regular frames (1-9)
          [(< (first frame-info) 10)
           (let ([frame-rolls (get-frame-rolls (first frame-info))])
             (cond
               [(null? frame-rolls) (<= pins 10)]
               [(= (length frame-rolls) 1)
                (<= pins (- 10 (first frame-rolls)))]
               [else #f]))]
          ; 10th frame
          [(= (first frame-info) 10)
           (let ([tenth-rolls (get-tenth-frame-rolls)])
             (cond
               [(null? tenth-rolls) (<= pins 10)]
               [(= (length tenth-rolls) 1)
                (if (= (first tenth-rolls) 10)
                    (<= pins 10)  ; After strike, reset pins
                    (<= pins (- 10 (first tenth-rolls))))]
               [(= (length tenth-rolls) 2)
                (let ([first-roll (first tenth-rolls)]
                      [second-roll (second tenth-rolls)])
                  (cond
                    ; After two strikes
                    [(and (= first-roll 10) (= second-roll 10))
                     (<= pins 10)]
                    ; After strike and non-strike
                    [(= first-roll 10)
                     (<= pins (- 10 second-roll))]
                    ; After spare
                    [(= (+ first-roll second-roll) 10)
                     (<= pins 10)]
                    ; No bonus rolls
                    [else #f]))]
               [else #f]))]
          [else #f])))
    
    ; Helper: Get current frame number and position in frame
    (define (get-current-frame-info)
      (let loop ([frame 1] [roll-idx 0])
        (cond
          [(>= roll-idx (length rolls)) (list frame 0)]
          [(> frame 10) (list 11 0)]  ; Game over
          [(< frame 10)
           (let ([pins (list-ref rolls roll-idx)])
             (if (= pins 10)  ; Strike
                 (loop (+ frame 1) (+ roll-idx 1))
                 (if (< (+ roll-idx 1) (length rolls))
                     (loop (+ frame 1) (+ roll-idx 2))
                     (list frame 1))))]  ; Second roll pending
          [(= frame 10)
           (let ([tenth-rolls (get-tenth-frame-rolls)])
             (list 10 (length tenth-rolls)))])))
    
    ; Helper: Get rolls for a specific frame (1-9)
    (define (get-frame-rolls frame-num)
      (let loop ([frame 1] [idx 0] [result '()])
        (cond
          [(or (>= idx (length rolls)) (> frame 9)) result]
          [(= frame frame-num)
           (let ([pins (list-ref rolls idx)])
             (if (= pins 10)
                 (list pins)
                 (if (< (+ idx 1) (length rolls))
                     (list pins (list-ref rolls (+ idx 1)))
                     (list pins))))]
          [else
           (let ([pins (list-ref rolls idx)])
             (if (= pins 10)
                 (loop (+ frame 1) (+ idx 1) result)
                 (loop (+ frame 1) (+ idx 2) result)))])))
    
    ; Helper: Get all rolls in 10th frame
    (define (get-tenth-frame-rolls)
      (let loop ([frame 1] [idx 0])
        (cond
          [(>= idx (length rolls)) '()]
          [(< frame 10)
           (let ([pins (list-ref rolls idx)])
             (if (= pins 10)
                 (loop (+ frame 1) (+ idx 1))
                 (loop (+ frame 1) (+ idx 2))))]
          [else
           (drop rolls idx)])))
    
    ; Helper: Check if game is complete
    (define (game-complete?)
      (let ([frame-info (get-current-frame-info)])
        (cond
          [(< (first frame-info) 10) #f]
          [(> (first frame-info) 10) #t]
          [(= (first frame-info) 10)
           (let ([tenth-rolls (get-tenth-frame-rolls)])
             (cond
               [(< (length tenth-rolls) 2) #f]
               [(= (length tenth-rolls) 2)
                (let ([first-roll (first tenth-rolls)]
                      [second-roll (second tenth-rolls)])
                  (not (or (= first-roll 10)
                           (= (+ first-roll second-roll) 10))))]
               [(>= (length tenth-rolls) 3) #t]
               [else #f]))])))
    
    ; Helper: Calculate the total score
    (define (calculate-score)
      (let loop ([frame 1] [roll-idx 0] [total 0])
        (cond
          [(> frame 10) total]
          [(< frame 10)
           (let ([first-roll (list-ref rolls roll-idx)])
             (cond
               ; Strike
               [(= first-roll 10)
                (let ([bonus1 (list-ref rolls (+ roll-idx 1))]
                      [bonus2 (list-ref rolls (+ roll-idx 2))])
                  (loop (+ frame 1) (+ roll-idx 1) 
                        (+ total 10 bonus1 bonus2)))]
               ; Spare or regular
               [else
                (let ([second-roll (list-ref rolls (+ roll-idx 1))])
                  (if (= (+ first-roll second-roll) 10)
                      ; Spare
                      (let ([bonus (list-ref rolls (+ roll-idx 2))])
                        (loop (+ frame 1) (+ roll-idx 2)
                              (+ total 10 bonus)))
                      ; Regular
                      (loop (+ frame 1) (+ roll-idx 2)
                            (+ total first-roll second-roll))))]))]
          ; 10th frame
          [else
           (let ([tenth-rolls (get-tenth-frame-rolls)])
             (+ total (apply + tenth-rolls)))])))))