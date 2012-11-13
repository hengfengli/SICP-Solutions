#lang scheme
(define (iterative-improve good-enough? improve)
  (define (recur guess)
    (if (good-enough? guess)
        guess
        (recur (improve guess))))
  (lambda (x) (recur x)))

; rewrite 1.17 sqrt
(define (square x) (* x x))
(define (average x y) (/ (+ x y) 2))
(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))
(define (improve guess x)
  (average guess (/ x guess)))

(define (sqrt x)
  ((iterative-improve
   (lambda (guess) (good-enough? guess x))
   (lambda (guess) (improve guess x)))
   x))

(sqrt 2.0)

; rewrite 1.3.3 fixed-point
(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  ((iterative-improve 
    (lambda (guess) (close-enough? guess (f guess))) 
    f) 
   first-guess))

(fixed-point (lambda (y) (+ (sin y) (cos y)))
             1.0)

(define (sqrt2 x)
  (fixed-point (lambda (y) (average y (/ x y)))
               1.0))

(sqrt2 2)