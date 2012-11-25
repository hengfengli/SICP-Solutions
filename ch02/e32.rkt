#lang scheme
(define nil '())

(define (subsets s)
  (if (null? s)
      (list nil)
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda 
                              (x) (append (list (car s)) x)) rest)))))

(subsets (list 1 2 3))

; for exaple, the set (1,2,3) has the rest of subsets (2,3) and the subsets of (1,2,3) are 
; equivalent to the combinations between 1 and subsets (2,3) plus subsets (2,3), and so on.