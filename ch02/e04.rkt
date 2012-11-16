#lang scheme
(define (cons x y)
  (lambda (m) (m x y)))

; (lambda (m) (m 1 2))

(define (car z)
  (z (lambda (p q) p)))

; ((lambda (m) (m 1 2) (lambda (p q) p))
; ((lambda (1 2) 1

(define (cdr z)
  (z (lambda (p q) q)))