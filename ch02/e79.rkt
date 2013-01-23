#lang scheme
(define (install-equ-package)
  (put 'equ? '(scheme-number scheme-number)
       (lambda (x y) (= x y)))
  (put 'equ? '(rational rational)
       (lambda (x y) ((and (= (numer x) (numer y))
                           (= (denom x) (denom y))))))
  (put 'equ? '(complex complex)
       (lambda (x y) 
         (cond ((and (rectangular? x) (rectangular? y))
                (and (= (real-part x) (real-part y))
                     (= (imag-part x) (imag-part y))))
               ((and (polar? x) (polar? y))
                (and (= (magnitude x) (magnitude y))
                     (= (angle x) (angle y))))
               (else
                false)))))

(define (equ? x y) (apply-generic 'equ? x y))