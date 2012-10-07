#lang scheme
; two precedure implement the addition method, one is the recursive process
; and another one is the iterative process
(define (+ a b)
  (if (= a 0)
      b
      (inc (+ (dec a) b))))
; it's evaluation process:
; (+ 4 5)
; (inc (+ 3 5))
; (inc (inc (+ 2 5)))
; (inc (inc (inc (+ 1 5))))
; (inc (inc (inc (inc (+ 0 5)))))
; (inc (inc (inc (inc 5))))
; (inc (inc (inc 6)))
; (inc (inc 7))
; (inc 8)
; 9

(define (+ a b)
  (if (= a 0)
      b
      (+ (dec a) (inc b))))
; it's evaluation process:
; (+ 4 5)
; (+ (dec 4) (inc 5))
; (+ (dec 3) (inc 6))
; (+ (dec 2) (inc 7))
; (+ (dec 1) (inc 8))
; 9