#lang scheme
; time complexity: O(n)
(define (* a b)
  (if (= b 0)
      0
      (+ a (* a (- b 1)))))

; time complexity: O(logn)
(define (multi a b)
  (cond ((= b 0) 0)
        ((even? b) (double (multi a (halve b))))
        (else (+ a (multi a (- b 1))))))

; e.g., 
; 3*12
; 2*(3*6)
; 2*2*(3*3)
; 2*2*(3*2+3)
; 2*2*(2*(3*1)+3)
; 2*2*(2*(3*0+3)+3)