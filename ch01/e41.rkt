#lang scheme
(define (inc i) (+ i 1))
(define (double p)
  (lambda (x) (p (p x))))