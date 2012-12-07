#lang scheme
; What is the order of growth in the number of steps needed to encode 
; a symbol?

; Assume there are n encoded symbols.
; The height of the encode tree is n-1.
; And at each intermediate node, the search process takes O(n) steps.
; So the time complexity is O(n^2).

;  the most frequent symbol: O(n)    (best case)
; the least frequent symbol: O(n^2)  (worse case)