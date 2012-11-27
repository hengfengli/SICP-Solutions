#lang scheme

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (count-leaves t)
  (accumulate +
              0
              (map (lambda (tree) (if (not (pair? tree)) 1 (count-leaves tree)))
                   t)))
              

(define x (cons (list 1 2) (list 3 4)))

(count-leaves x)
(count-leaves (list x x))

