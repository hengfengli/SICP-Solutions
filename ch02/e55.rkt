#lang scheme
(car ''abracadabra)

;see footnote 34
; the ' is just syntax sugar which will be replaced by 'quote'
; when interpreter interprets it.

; see below, the result is as same as above.
(car (quote (quote (abracadabra))))