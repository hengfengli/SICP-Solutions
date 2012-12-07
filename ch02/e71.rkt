#lang scheme



; n = 5
;           {a b c d e} 31 = 1 + 2 + 4 + 8 + 16
;            /         \ 
;       {a b c d} 15    e 16
;         /     \
;  {a b c} 7     d 8
;      /   \ 
;   {a b}   c 4
;   /   \
; a 1    b 2

; 1 bit for the most frequent symbol
; n-1 bits for the least frequent symbol