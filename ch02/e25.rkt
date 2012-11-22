#lang scheme
(define test1 (list 1 3 (list 5 7) 9))

(car (cdr (car (cdr (cdr test1)))))

(define test2 (list (list 7)))

(car (car test2))

(define test3 (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7)))))))

(car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr test3))))))))))))