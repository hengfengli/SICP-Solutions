#lang scheme
(define (install-zero-package)
  (put '=zero? '(scheme-number)
       (lambda (x) (= x 0)))
  (put '=zero? '(rational)
       (lmabda (x) (= (numer x) 0)))
  (put '=zero? '(complex complex)
       (lambda (x)
         (cond ((rectangular? x)
                (and (= (real-part x) 0)
                     (= (imag-part x) 0)))
               ((and (polar? x))
                (= (magnitude x) 0))
               (else
                false)))))

(define (=zero? x) (apply-generic '=zero? x))