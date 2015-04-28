#lang racket
(define (close-enough? x y)
  (< (abs (- x y)) 0.001))

(define (average x y) (/ (+ x y) 2))

; fixed point of function
(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (report-guess guess)
    (display " *** ")
    (display guess))
  (define (try guess)
    (let ((next (f guess)))
      (report-guess guess)
      (newline)
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

; find a solution to x^x = 1000 by finding a fixed point of x -> log(1000)/log(x)
(define (x_x)
  (fixed-point (lambda (x) (/ (log 1000) (log x))) 2.0))

(define (avg_damping)
  (fixed-point (lambda (x) 
                 (average x (/ (log 1000) (log x)))) 2.0))