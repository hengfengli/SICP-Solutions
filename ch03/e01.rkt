#lang racket

(define (make-accumulator balance)
  (lambda (amount) 
    (set! balance (+ balance amount))
    balance))

(define A (make-accumulator 5))