#lang scheme
(define nil '())

(define (even? x) (= (remainder x 2) 0))
(define (same-parity x . y)
  (define (filter z) (eq? (even? x) (even? z)))
  (define (iter f list)
    (if (null? list)
        nil
        (if (filter (car list))
            (cons (car list)
                  (iter f (cdr list)))
            (iter f (cdr list)))))
  (cons x (iter filter y)))

(same-parity 1 2 3 4 5 6 7)
(same-parity 2 3 4 5 6 7)