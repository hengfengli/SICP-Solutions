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

(define (deep-reverse l)
  (if (null? l)
      nil
      (append (deep-reverse (cdr l))
              (list (if (list? (car l))
                        (deep-reverse (car l))
                        (car l))))))

(define x (list (list (list 1 2) (list 3 4)) (list 3 4)))

x

(reverse x)

(deep-reverse x)