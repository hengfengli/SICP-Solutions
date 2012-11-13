#lang scheme
(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (define (iter i g)
    (if (= i 1)
        g
        (iter (- i 1) (compose g g))))
  (lambda (x) ((iter n f) x)))

(define (average x y) (/ (+ x y) 2))

; fixed point of function
(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
;  (define (report-guess guess)
;    (display " *** ")
;    (display guess))
  (define (try guess)
    (let ((next (f guess)))
;      (report-guess guess)
;      (newline)
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (fixed-point-of-transform g transform guess)
  (fixed-point (transform g) guess))

; e45
(define (average-damp-root x n i)
  (fixed-point-of-transform (lambda (y) (/ x (expt y (- n 1))))
                            (repeated average-damp i)
                            1.0))

; 2^2 2
; 2^3 3
; 2^5 4
; 2^9 5
; one possible: i = log n / log 2