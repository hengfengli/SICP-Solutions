#lang scheme
(define (make-interval a b) (cons a b))
(define (upper-bound z) (cdr z))
(define (lower-bound z) (car z))

(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))
(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))
(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

(define (make-center-percent c tolerance)
  (let ((wd (* (/ tolerance 100) c)))
    (make-center-width c wd)))

(define (percent z)
  (* (/ (- (center z) (lower-bound z)) (center z)) 100))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define z1 (make-center-percent 6.8 0.1))
(define z2 (make-center-percent 5 0.1))
(define z3 (mul-interval z1 z2))
(display z3)
(newline)
(percent z3)
(center z3)

; c_z + w_z = (c_x + w_x) * (c_y + w_y)
; c_z + w_z = c_x * c_y + c_x * w_y + c_y * w_x + w_x * w_y

; c_z = c_x * c_y
; w_z = c_x * w_y + c_y * w_x + w_x * w_y

; ignore w_x * w_y
; w_z/c_z = (c_x * w_y)/(c_x * c_y) + (c_y * w_x)/(c_x * c_y))
; w_z/c_z = w_y/c_y + w_x/c_x
; t_z = t_y + t_x