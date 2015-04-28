#lang scheme
; normal-order evaluation
; (gcd 206 40)
; (gcd 40 (remainder 206 40))

; In the normal-order evaluation, the parameter will not 
; be computed until meeting primitive operations.

;(if (= (remainder 206 40) 0)   ; one time
;    40
;    (gcd (remainder 206 40)
;         (remainder 40 (remainder 206 40))))

; applicative-order evaluation
;(gcd 206 40)
;(gcd 40 (remainder 206 40))
;(gcd 40 6)
;(gcd 6 (remainder 40 6))
;(gcd 6 4)
;(gcd 4 (remainder 6 4))
;(gcd 4 2)
;(gcd 2 (remainder 4 2))
;(gcd 2 0)

