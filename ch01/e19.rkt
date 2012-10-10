#lang scheme
; This question proposes a new method with logarithmic number of steps.
; We compute the fibonacci by using such a transformation based on an iterative process.
; a <- a + b
; b <- a

; if we treat the above transformation as T, Fib(n+1) and Fib(n) is computed by T^n.
; assume that:
; a <- bq + aq + ap
; b <- bp + aq
; when p=0, q=1, it is a case of that transformation.

; the question say if this transformation is applied twice, 
; it will become as fowllow:
; a <- bq' + aq' + ap'
; b <- bp' + aq'
; which means: (T_pq)^2 = T_q'p'

; so we need to find the relationship between q,p and q',p'.

; a <- b(q^2+2pq) + a(q^2+2pq) + a(q^2+p^2)
; b <- b(p^2+q^2) + a(q^2+2pq)

; p' = p^2+q^2
; q' = q^2+2pq

; So the code can be completed.
(define (fib n)
  (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count)
         (fib-iter a
                   b
                   (+ (* p p) (* q q))
                   (+ (* q q) (* 2 p q))
                   (/ count 2)))
        (else (fib-iter (+ (* b q) (* a q) (* a p))
                        (+ (* b p) (* a q))
                        p
                        q
                        (- count 1)))))