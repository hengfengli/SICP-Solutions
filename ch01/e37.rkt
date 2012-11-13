#lang racket
; a
(define (cont-frac n d k)
  (define (recur x)
    (if (= x k)
        (/ (n x) (d x))
        (/ (n x) (+ (d x) (recur (+ x 1))))))
  (recur 1))

; b
(define (cont-frac-iter n d k)
  (define (iter x result)
    (if (= x 0)
        result
        (iter (- x 1)
              (/ (n x) (+ (d x) result)))))
  (iter k 0))

(cont-frac (lambda (i) 1.0) (lambda (i) 1.0) 11)
(cont-frac-iter (lambda (i) 1.0) (lambda (i) 1.0) 11)