#lang scheme

; Based on the previous exercise, it can be proved that:
; par2 produce tighter error bounds.
; 
; (par1 z3 z4)
; (3.323346653346653 . 3.343346680013347)
; (par2 z3 z4)
; (3.33 . 3.3366666666666664)

; Why?
; http://en.wikipedia.org/wiki/Interval_arithmetic#Dependency_problem
; "If an interval occurs several times in a calculation using parameters, 
; and each occurrence is taken independently then this can lead to an unwanted 
; expansion of the resulting intervals."

; In par1, each intervals occur twice, but in par2, every interval just occurs
; once. So the par2's unwanted expansions are less than par1.