#lang racket

; integer -> rational
(put 'raise 'integer
     (lambda (n)
       (make-rational n 1)))

; rational -> real
(put 'raise 'rational
     (lambda (n)
       (make-scheme-number (/ (car x) (cdr x)))))

(define (raise n)
  (apply-generic 'raise n))