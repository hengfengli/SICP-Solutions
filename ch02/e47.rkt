#lang scheme
(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (origin-frame frame)
  (car frame))

(define (edge1-frame frame)
  (car (cdr frame)))

(define (edge2-frame frame)
  (car (cdr (cdr frame))))

(define test1 (make-frame 1 2 3))
(origin-frame test1)
(edge1-frame test1)
(edge2-frame test1)

(define (make-frame-2 origin edge1 edge2)
  (cons origin (cons edge1 edge2)))

(define (edge2-frame-2 frame)
  (cdr (cdr frame)))

(define test2 (make-frame-2 1 2 3))
(origin-frame test2)
(edge1-frame test2)
;; different
(edge2-frame-2 test2)
