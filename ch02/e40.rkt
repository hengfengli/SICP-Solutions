#lang scheme
(define (square x) (* x x))
(define (prime? n)
  (= n (smallest-divisor n)))
(define (smallest-divisor n)
  (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))
(define (divides? a b)
  (= (remainder b a) 0))

(define nil '())
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (append (cdr list1) list2))))

(define (enumerate-interval low high)
  (if (> low high)
      nil
      (cons low (enumerate-interval (+ low 1) high))))

(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

(define (remove item sequence)
  (filter (lambda (x) (not (= x item)))
          sequence))

(define (permutations s)
  (if (null? s)
      (list nil)
      (flatmap (lambda (x)
                 (map (lambda (p) (cons x p))
                      (permutations (remove x s))))
               s)))

(permutations (list 1 2 3))

; I am trying to understand the function of 'flatmap' here, so I
; make some tests to analyse each components functions.

(define (enumerate-combinaitons n)
   (map (lambda (i)                       ; generate n sequences
          (map (lambda (j) (list i j))    ; generate i and j combinations
               (enumerate-interval 1 (- i 1))))
        (enumerate-interval 1 n)))

; (enumerate-combinaitons 10)  ; several sequences
; (accumulate append nil (enumerate-combinaitons 10)) ; construct one sequence

; back to the e2.40

; Actually, this unique-pairs is almost as same as the 
; 'enumerate-combinations' I writer above. It can generate
; the a sequence of pairs(i,j), 1 <= j <= i <= n
(define (unique-pairs n)
   (flatmap
    (lambda (i)
      (map (lambda (j) (list i j))
           (enumerate-interval 1 (- i 1))))
    (enumerate-interval 1 n)))

(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum? (unique-pairs n))))

(prime-sum-pairs 6)