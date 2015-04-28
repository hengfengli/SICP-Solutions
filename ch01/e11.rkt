#lang scheme
; write two evaluation processes to compute
; f(n) = n if n < 3
; f(n) = f(n-1)+2f(n-2)+3f(n-3) if n >= 3
; recursive process
(define (f-r n)
  (cond ((< n 3) n)
        (else (+ (f-r (- n 1))
                 (* 2 (f-r (- n 2)))
                 (* 3 (f-r (- n 3)))))))

; iterative process
; a = a + 2b + 3c
; b = a
; c = b
(define (f-i n)
  (if (< n 3)
      n
      (f-iter 2 1 0 n)))

(define (f-iter a b c count)
  (if (= count 2)
      a
      (f-iter (+ a (* 2 b) (* 3 c))
              a
              b
              (- count 1))))
; when n equals to 3, (f-iter 2 1 0 3) will compute one time.