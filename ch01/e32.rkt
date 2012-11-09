#lang scheme
(define (inc n) (+ n 1))
(define (self n) n)
(define (add a b) (+ a b))
(define (times a b) (* a b))

; a
(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate combiner null-value term (next a) next b))))

(define (sum term a next b)
  (accumulate add 0 term a next b))

(define (product term a next b)
  (accumulate times 1 term a next b))

; b
(define (accumulate-iter combiner null-value term a next b)
  (define (iter x result)
    (if (> x b)
        result
        (iter (next x) (combiner (term x) result))))
  (iter a null-value))

(define (sum-iter term a next b)
  (accumulate-iter add 0 term a next b))
