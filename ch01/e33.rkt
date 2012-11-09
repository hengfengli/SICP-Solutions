#lang scheme
(define (inc n) (+ n 1))
(define (self n) n)
(define (add a b) (+ a b))
(define (times a b) (* a b))
(define (square a) (* a a))
(define (even? a) (= 0 (remainder a 2)))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (filtered-accumulate filter? combiner null-value term a next b)
  (if (> a b)
      null-value
      (if (filter? a)
          (combiner (term a)
                    (filtered-accumulate filter? combiner null-value term (next a) next b))
          (filtered-accumulate filter? combiner null-value term (next a) next b))))

; a
(define (filtered-prime-sum a b)
  (filtered-accumulate prime? add 0 square a inc b))

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

; b
(define (filtered-prime-product n)
  (define (filter? i) (= 1 (gcd i n)))
  (filtered-accumulate filter? times 1 self 1 inc n))
