#lang racket

(define (make-monitored f)
  (define counter 0)
  (define (dispatch m)
    (cond ((eq? m 'how-many-calls?) counter)
          ((number? m)
           (set! counter (+ counter 1))
           (f m))
          (else (error "Unknown request -- MAKE-MONITORED"
                       m))))
  dispatch)

(define s (make-monitored sqrt))