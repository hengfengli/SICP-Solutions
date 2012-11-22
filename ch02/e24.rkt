#lang scheme
(define x (cons (list 1 2) (list 3 4)))

(length x)

(define (count-leaves x)
  (cond ((null? x) 0)
        ((not (pair? x)) 1)
        (else (+ (count-leaves (car x))
                 (count-leaves (cdr x))))))

(count-leaves x)

; e2.24
(list 1 (list 2 (list 3 4)))

; (1 (2 (3 4)))
; It's a tree structure.