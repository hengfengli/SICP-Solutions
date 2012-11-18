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


; 2.10
(define (div-interval x y)
  (if (and (>= (upper-bound y) 0)
           (<= (lower-bound y) 0))
      (error "Spaning zero")
      (mul-interval x
                    (make-interval (/ 1.0 (upper-bound y))
                                   (/ 1.0 (lower-bound y))))))

(define x1 (make-interval 2 4))
(define x2 (make-interval -1 2))
(div-interval x1 x2)