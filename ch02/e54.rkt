#lang scheme



(define (memq item x)
  (cond ((null? x) false)
        ((eq? item (car x)) x)
        (else (memq item (cdr x)))))

(define (equal? a b)
  (cond ((null? a) (null? b))
        ((null? b) (null? a)) 
        ((and (symbol? a) (symbol? b)) (eq? a b))
        ((and (list? a) (list? b)) (and (equal? (car a) (car b))
                                        (equal? (cdr a) (cdr b))))
        (else false)))

(equal? '(this is a list) '(this is a list))

(equal? '(this is a list) '(this (is a) list))