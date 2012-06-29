#lang scheme
(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x)
                     x)))

; if statement is a special form, it would not compute all 
; the parameters' values at first. 
; However, if you define a procedure to replace the if 
; statement, it will compute all the subexpressions firstly. 

; The new-if will compute all its subexpressions so that 
; 'sqrt-iter' will be called into a ever loop.