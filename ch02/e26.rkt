#lang scheme
(define x (list 1 2 3))
(define y (list 4 5 6))

(append x y)  ; append a list x to a list y
; (1 2 3 4 5 6)

(cons x y)  ; prepend a element x to a list y
; ((1 2 3) 4 5 6)

(list x y) ; construct a new list
; ((1 2 3) (4 5 6))