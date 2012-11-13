#lang scheme
(define (f g)
  (g 2))

(define (square x) (* x x))

(f square)

(f (lambda (z) (* z (+ z 1))))

; application: not a procedure;
; expected a procedure that can be applied to arguments
; given: 2

;(f f)
;(f 2)
;(2 2)  <- error