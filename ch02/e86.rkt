#lang scheme

; Try to let complex number's real, imaginary, magnitudes,
; and angles, being able to be represented by
; ordinary numbers and rational numbers.

; only need to modify those accessors for complex numbers.
(define (real-part x)
  (apply-generic 'real-part x))

(define (imag-part x)
  (apply-generic 'imag-part x))

(define (magnitude x)
  (apply-generic 'magnitude x))

(define (angle x)
  (apply-generic 'angle x))

; then define those accessors with different types,
; and put them into the table.


(define (tag x)
  (attach-tag 'scheme-number))

(put 'sin 'scheme-number
     (lambda (x) ((tag (sin x)))))

(put 'cos 'scheme-number
     (lambda (x) ((tag (cos x)))))

(put 'sin 'rational
     (lambda (x) ((tag (sin (/ (numer x)
                               (denom x)))))))

(put 'cos 'rational
     (lambda (x) ((tag (cos (/ (numer x)
                               (denom x)))))))

(define (sine x)
  (apply-generic 'sin x))
(define (cosine x)
  (apply-generic 'cos x))