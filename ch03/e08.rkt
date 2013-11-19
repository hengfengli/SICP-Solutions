#lang racket

; return 0 if "+" left  -> right
; return 1 if "+" right -> left

;(define f 
;  (let ((init 1))
;    (lambda (x)
;      (set! init (* init x))
;      init)))

(define f
  (let ((state 1))
    (lambda (n)
      (set! state (* state n))
      state)))

;(+ (f 0) (f 1))
; => 0 + 0 = 1

;(+ (f 1) (f 0))
; => 1 + 0 = 1