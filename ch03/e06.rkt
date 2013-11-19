#lang racket

(define (rand-update x) (random (expt 2 5)))
(define (random-init) (rand-update 0))

(define rand
  (let ((x random-init))
    (lambda (m)
      (cond ((eq? m 'generate)
             (set! x (rand-update x))
             x)
            ((eq? m 'reset)
             (lambda (new-value)
               (set! x new-value)))))))