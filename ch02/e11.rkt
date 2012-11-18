#lang scheme
(define (make-interval a b) (cons a b))

; 2.7
(define (upper-bound z) (cdr z))
(define (lower-bound z) (car z))

(define (mul-interval x y)
  (let ((lower-x (lower-bound x))
        (upper-x (upper-bound x))
        (lower-y (lower-bound y))
        (upper-y (upper-bound y)))
    (cond ((and (>= lower-x 0) (>= upper-x 0)    ; x:++ y:++
                (>= lower-y 0) (>= upper-y 0))
           (make-interval (* lower-x lower-y) (* upper-x upper-y)))
          ((and (>= lower-x 0) (>= upper-x 0)    ; x:++ y:-+
                (< lower-y 0) (>= upper-y 0))
           (make-interval (* upper-x lower-y) (* upper-x upper-y)))
          ((and (>= lower-x 0) (>= upper-x 0)    ; x:++ y:--
                (< lower-y 0) (< upper-y 0))
           (make-interval (* upper-x lower-y) (* lower-x upper-y)))
          
          ((and (< lower-x 0) (>= upper-x 0)    ; x:-+ y:++
                (>= lower-y 0) (>= upper-y 0))
           (make-interval (* lower-x upper-y) (* upper-x upper-y)))
          ((and (< lower-x 0) (>= upper-x 0)    ; x:-+ y:-+
                (< lower-y 0) (>= upper-y 0))
             (let ((p1 (* lower-x lower-y))
                   (p2 (* lower-x upper-y))
                   (p3 (* upper-x lower-bound y))
                   (p4 (* upper-x upper-bound y)))
               (make-interval (min p1 p2 p3 p4)
                              (max p1 p2 p3 p4))))
          ((and (< lower-x 0) (>= upper-x 0)    ; x:-+ y:--
                (< lower-y 0) (< upper-y 0))
           (make-interval (* upper-x lower-y) (* lower-x lower-y)))
          
          ((and (< lower-x 0) (< upper-x 0)    ; x:-- y:++
                (>= lower-y 0) (>= upper-y 0))
           (make-interval (* lower-x upper-y) (* upper-x lower-y)))
          ((and (< lower-x 0) (< upper-x 0)    ; x:-- y:-+
                (< lower-y 0) (>= upper-y 0))
           (make-interval (* lower-x upper-y) (* lower-x lower-y)))
          ((and (< lower-x 0) (< upper-x 0)    ; x:-- y:--
                (< lower-y 0) (< upper-y 0))
           (make-interval (* upper-x upper-x) (* lower-x lower-y))))))
          


