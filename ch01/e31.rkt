#lang scheme
(define (self x) x)
(define (inc n) (+ n 1))
(define (even? x) (= 0 (remainder x 2)))

; a
(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

; factorial
(define (factorial x)
  (product self 1 inc x))

; pi/4
(define (pi n)
  (define (term x) 
    (if (not (even? x))
        (/ (+ x 1) (+ x 2))
        (/ (+ x 2) (+ x 1))))
  (* 4
     (exact->inexact (product term 1 inc n))))

; b
(define (product-iter term a next b)
  (define (iter x result)
    (if (> x b)
        result
        (iter (next x) (* (term x) result))))
  (iter a 1))