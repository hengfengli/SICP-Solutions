#lang scheme
(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (mul-interval x
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))))

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

(define (width z)
  (/ (- (upper-bound z) (lower-bound z)) 2))


(define x1 (make-interval 7 10))
(define x2 (make-interval 2 4))

(width x1)
(width x2)

(define z1 (add-interval x1 x2))
(width z1)
(define z2 (sub-interval x1 x2))
(width z2)
(define z3 (mul-interval x1 x2))
(width z3)
(define z4 (div-interval x1 x2))
(width z4)

; For add and sub, it is the sum of widths.
; However, for the mul and div, it does not.