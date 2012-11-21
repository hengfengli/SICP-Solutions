#lang scheme
(define nil '()) ; no define in this scheme version

(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (append (cdr list1) list2))))

(define (reverse l)
  (if (null? l)
      nil
      (append (reverse (cdr l)) 
              (list (car l)))))

(reverse (list 23 72 149 34))