#lang scheme
(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (make-interval a b) (cons a b))

; 2.7
(define (upper-bound z) (cdr z))
(define (lower-bound z) (car z))

; 2.8
(define (sub-interval x y)
  (add-interval x
                (make-interval (min (- (lower-bound y)) 
                                    (- (upper-bound y)))
                               (max (- (lower-bound y))
                                    (- (upper-bound y))))))
 
(define x1 (make-interval 2 4))
(define x2 (make-interval 1 3))

(add-interval x1 x2)
(sub-interval x1 x2)