#lang scheme
(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

;a 
(define left-branch car)
(define (right-branch z) (car (cdr z)))
; (define (right-branch z) (cdr z))

(define branch-length car)
(define (branch-structure z) (car (cdr z)))
; (define (branch-structure z) (cdr z))

;b
(define (test-branch branch)
  (if (list? branch)
      (total-weight branch)
      branch))

(define (total-weight mobile)
  (cond ((null? mobile) 0)
        (else
         (let ((left-branch (branch-structure (left-branch mobile)))
               (right-branch (branch-structure (right-branch mobile))))
           (+ (test-branch left-branch)
              (test-branch right-branch))))))

; test cases
(define test1 (make-mobile (make-branch 10 5) (make-branch 3 6)))
(define test2 (make-mobile (make-branch 4 test1) (make-branch 2 7)))
(total-weight test2)

(branch-structure (make-branch 4 test1))
;c
(define (balanced? mobile)
  (let ((left-length (branch-length (left-branch mobile)))
        (right-length (branch-length (right-branch mobile)))
        (left-structure (branch-structure (left-branch mobile)))
        (right-structure (branch-structure (right-branch mobile))))
    (= (* left-length (test-branch left-structure))
       (* right-length (test-branch right-structure)))))

(balanced? test2)

;d

; only for accessors.

;(define (make-mobile left right)
;  (cons left right))
;(define (make-branch length structure)
;  (cons length structure))

; (define (right-branch z) (cdr z))
; (define (branch-structure z) (cdr z))

;(define (test-branch branch)
;  (if (pair? branch)
;      (total-weight branch)
;      branch))
