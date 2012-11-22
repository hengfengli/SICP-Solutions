#lang scheme
(define nil '())
(define (square x) (* x x))

; it shoule be like (cons answer (square (car things)))

(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square (car things))))))
  (iter items nil))

(square-list (list 1 2 3))

; cons support prepending a new element to a list, 
; but it does not generate traditional list for appending
; a new element. (consider the structure of a list)