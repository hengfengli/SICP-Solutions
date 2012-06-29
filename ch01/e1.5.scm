#lang scheme
(define (p) (p))

(define (test x y)
  (if (= x 0)
      0
      y))

(test 0 (p))

; The difference between applicative-order and normal-order
; Applicative-order will compute the (p) at first, which 
; causes a non-end loop. 
; Normal-order will expand the procedure firstly and compute
; until meets the primitive operators. When it meets the if 
; statement, as the program finds that the predicate equals 0 and
; that the reulst of function is 0, (p) is not called.