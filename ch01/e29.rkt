#lang scheme
(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)
     dx))

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (inc n) (+ n 1))
(define (cube x) (* x x x))
(define (even? x) (= 0 (remainder x 2)))

; Simpson's Rule -> numerical integration
(define (simpson-integral f a b n)
  (let ((h (exact->inexact (/ (- b a) n))))
    (define (simpson-term k) 
      (* (f (+ a (* k h)))
         (cond ((or (= k 0) (= k n)) 1)
               ((even? k) 2)
               (else 4))))
    (* (/ h 3)
       (sum simpson-term 0 (lambda (x) (+ x 1)) n))))

