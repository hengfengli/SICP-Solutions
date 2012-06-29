#lang scheme
(define (square x) (* x x))

(define (maxTwo a b c)
  (cond ((and (< a b) (< a c))
         (+ (square b) (square c)))
        ((and (< b c) (< b a))
         (+ (square a) (square c)))
        (else (+ (square a) (square b)))))