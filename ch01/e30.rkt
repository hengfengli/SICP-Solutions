#lang scheme
(define (inc n) (+ n 1))
(define (cube x) (* x x x))

(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)
     dx))

; iter sum procedure
(define (sum term a next b)
  (define (iter x result)
    (if (> x b)
        result
        (iter (next x) (+ (term x) result))))
  (iter a 0))
