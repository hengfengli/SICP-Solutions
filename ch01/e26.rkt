#lang scheme
; Because the double call to itsself causes it transforming 
; from a linear recursion to a tree recursion.
;
; Originally, it just calls one time in each step. And there 
; are logn steps so the time complexity is O(logn).
;
; However, Louis' double calls let it have two branches in 
; each step, which likes a binary tree. 
; 2^logN = N