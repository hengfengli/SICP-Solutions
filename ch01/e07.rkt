#lang scheme
(define (abs x)
  (if (< x 0)
      (- x)
      x))

(define (square x) (* x x))

(define (sqrt-iter guess x)
  (if (good-enough? (improve guess x) guess)
      guess
      (sqrt-iter (improve guess x)
                 x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? improve-guess guess)
  (< (abs (/ (- improve-guess guess) guess)) 0.001))

(define (sqrt x)
  (sqrt-iter 1.0 x))