#lang scheme
(define (compose f g)
  (lambda (x) (f (g x))))

(define (square x) (* x x))
(define (repeated f n)
  (define (iter i g)
    (if (= i 1)
        g
        (iter (- i 1) (compose g g))))
  (lambda (x) ((iter n f) x)))