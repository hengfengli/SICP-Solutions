#lang scheme
(define (square x) (* x x))

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

; compute a range of primes
(define (display-prime n)
  (newline)
  (display n)
  (display " is a prime"))

(define (even? n)
  (= (remainder n 2) 0))

(define (search-for-primes start end)
  (let ((start (if (even? start) (+ start 1) start)))
    (do ((i start (+ i 2)))
        ((> i end))
      (when (prime? i)
        (display-prime i)))))

(time (for ([i 1000]) (search-for-primes 1000 1019)))