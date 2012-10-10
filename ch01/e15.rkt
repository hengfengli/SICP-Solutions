#lang scheme
; if x is sufficiently small, sin(x) approx to x
; sin(x) = 3sin(x/3) - 4sin^3(x/3)
; sin(x/3) = ...
; until x/3 is less than 0.1, it will stop.
(define (cube x) (* x x x))

(define (p x) (- (* 3 x) (* 4 (cube x))))

(define (sine angle)
  (if (not (> (abs angle) 0.1))
      angle
      (p (sine (/ angle 3.0)))))

; a. 
; (sine 12.15)
; (p (sine 4.05))
; (p (p (sine 1.35)))
; (p (p (p (sine 0.45))))
; (p (p (p (p (sine 0.15)))))
; (p (p (p (p (p (sine 0.05))))))
; 5 times of p procedure applied

; b. both space and number of steps are O(log3^angle).