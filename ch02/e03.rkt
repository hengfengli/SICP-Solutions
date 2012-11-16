#lang scheme

(define (make-segment start end) (cons start end))
(define (start-segment x) (car x))
(define (end-segment x) (cdr x))

(define (make-point x y) (cons x y))
(define (x-point p) (car p))
(define (y-point p) (cdr p))


; diagonal point
(define (make-rect p1 p2)
  (cons p1 p2))

(define (rect-width rect) 
  (abs (- (x-point (car rect))
          (x-point (cdr rect)))))

(define (rect-height rect)
  (abs (- (y-point (car rect))
          (y-point (cdr rect)))))

(define (perimeter rect)
  (* 2 (+ (rect-width rect)
          (rect-height rect))))

(define (area rect)
  (* (rect-width rect)
     (rect-height rect)))

; diagonal line
(define (make-rect2 line1 line2)
  (cons (car line1) (cdr line2)))