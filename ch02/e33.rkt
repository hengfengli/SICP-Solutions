#lang scheme
(define (square x) (* x x))
(define nil '())

(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))

(define (sum-odd-squares tree)
  (cond ((null? tree) 0)
        ((not (pair? tree))
         (if (odd? tree) (square tree) 0))
        (else (+ (sum-odd-squares (car tree))
                 (sum-odd-squares (cdr tree))))))

(define (even-fibs n)
  (define (next k)
    (if (> k n) nil
        (let ((f (fib k)))
          (if (even? f)   
              (cons f (next (+ k 1)))
              (next (+ k 1))))))
  (next 0))

(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (enumerate-interval low high)
  (if (> low high)
      nil
      (cons low (enumerate-interval (+ low 1) high))))

(define (enumerate-tree tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (list tree))
        (else (append (enumerate-tree (car tree))
                      (enumerate-tree (cdr tree))))))

(define (sum-odd-squares-mod tree)
  (accumulate +
              0
              (map square
                   (filter odd?
                           (enumerate-tree tree)))))

(define (even-fibs-mod n)
  (accumulate cons
              nil
              (filter even?
                      (map fib
                           (enumerate-interval 0 n)))))

;(define (list-fib-squares n)
;  (accumulate cons
;              nil
;              (map square
;                   (map fib
;                        (enumerate-interval 0 n)))))

; (list-fib-squares 10)

(define (product-of-squares-of-odd-elements sequence)
  (accumulate *
              1
              (map square
                   (filter odd? sequence))))

; e2.33
(define (map p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) nil sequence))
(map square (list 1 2 3 4))

(define (append seq1 seq2)
  (accumulate cons seq2 seq1))
(append (list 1 2 3 4) (list 4 3 2 1))

(define (length sequence)
  (accumulate (lambda (x y) (+ x y)) 0 sequence))
(length (list 1 2 3 4))