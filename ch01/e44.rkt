#lang scheme
(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (define (iter i g)
    (if (= i 1)
        g
        (iter (- i 1) (compose g g))))
  (lambda (x) ((iter n f) x)))

; e44
(define dx 0.00001)
(define (average x y z) (/ (+ x y z) 3))
(define (smooth f)
  (lambda (x) (average (f (- x dx)) 
                       (f x)
                       (f (+ x dx)))))
(define (n_smooth f n)
  ((repeated smooth n) f))
              
  