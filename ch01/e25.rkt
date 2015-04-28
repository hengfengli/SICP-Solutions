#lang scheme
; this question says that we already know the method of fast-expt.
; why don't we use it to compute the exp power of base, and then module m.
; the reason is that if we compute the exp power of base at first, whose 
; result is huge than the size of an integer(32 bits). 
; But the author's method addresses it successfully due to conducting 
; module m in each iteration. 