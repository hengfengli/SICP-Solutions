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


(percent (make-center-percent 6.8 10))