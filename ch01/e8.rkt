#lang scheme
(define (cube x)
  (define (square x) (* x x))
  
  (define (good-enough? improve-guess guess)
    (< (abs (/ (- improve-guess guess) guess)) 0.001))
  
  (define (improve y)
    (/ (+ (/ x (square y))
          (* 2 y))
       3))
  
  (define (cube-iter guess)
    (if (good-enough? (improve guess) guess)
        guess
        (cube-iter (improve guess))))
  
  (cube-iter 1.0))