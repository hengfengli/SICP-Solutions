#lang scheme
; The question askes us to solve the problem in 1.27
; -- Miller-Rabin test
; It check "nontrivial square root of 1 modulo n", 
; which is the number not equal to 1 or n-1 whose
; square is equal to 1 modulo n.

(define (square x) (* x x))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (let* ( (cand (expmod base (/ exp 2) m))
                (root (remainder (square cand) m)))
           (if (and (not (= cand 1)) (not (= cand (- m 1))) (= root 1))
               0
               root)))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (miller-rabin-test n)
  (define (try-it a)
    (= (expmod a (- n 1) n) 1))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((miller-rabin-test n) (fast-prime? n (- times 1)))
        (else false)))

(fast-prime? 1105 3)