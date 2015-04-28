#lang racket
; a
(define (cont-frac n d k)
  (define (recur x)
    (if (= x k)
        (/ (n x) (d x))
        (/ (n x) (+ (d x) (recur (+ x 1))))))
  (recur 1))

(define (square x) (* x x))


(define (tan-cf x k)
  (define (n i)
    (if (= 1 i)
        x
        (- (square x))))
  (define (d i) (- (* 2 i) 1))
  (exact->inexact (cont-frac n d 10)))