#lang scheme
(define (split op1 op2)
  (lambda (painter)
    (if (= n 0)
        painter
        (let ((smaller (right-split painter (- n 1))))
          (op1 painter (op2 smaller smaller))))))
         
(define right-split (split beside below))
(define up-split (split below beside))