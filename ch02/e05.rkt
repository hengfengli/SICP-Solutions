#lang scheme
(define (cons a b)
  (* (expt 2 a) (expt 3 b)))

(define (divide-until base i x)
    (if (= (remainder x base) 0)
        (divide-until base (+ i 1) (/ x base))
        i))

(define (car z)
  (divide-until 2 0 z))

(define (cdr z)
  (divide-until 3 0 z))