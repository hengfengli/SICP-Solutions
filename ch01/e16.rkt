#lang scheme
; use iterative process to write fast-expt
(define (fast-expt x n)
  (expt-iter 1 x n))

(define (expt-iter a b n)
  (cond ((= n 0) a)
        ((even? n) (expt-iter a (* b b) (/ n 2)))
        (else (expt-iter (* a b) b (- n 1)))))

(define (even? n)
  (= (remainder n 2) 0))

; by using the formula (b^n/2)^2 = (b^2)^n/2
; a is used to store the case when n is an odd number
; e.g., 
; 3^10 = (3^2)^5 
; = 3^2 * (3^2)^4 
; = (3^2)*(3^2*2)^2 
; = (3^2)*(3^2*2*2)^1 
; = (3^2)*(3^2*2*2*2)^0