#lang scheme
(define (multi a b)
  (multi-iter 0 a b))

(define (multi-iter s a b)
  (cond ((= b 0) s)
        ((even? b) (multi-iter s (double a) (halve b)))
        (else (multi-iter (+ s a) a (- b 1)))))

; e.g., 
; 3*12
; multi-iter 0 3 12
; multi-iter 0 6 6
; multi-iter 0 12 3
; multi-iter 12 12 2
; multi-iter 12 24 1
; multi-iter 36 24 0