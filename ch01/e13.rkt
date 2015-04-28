#lang scheme
; This question needs to prove:
; Fib(n) is the closest integer to $\phi^{n}/\sqrt{5}$, where $\phi=(1+\sqrt{5})/2$.

; Hints:
; through $\psi=(1-\sqrt{5})/2$ to prove
; $Fib(n)=(\phi^{n}-\psi^{n})/\sqrt{5}$

; Use induction, base cases are
; $Fib(0) = (phi^{0} - psi^{0})/ \sqrt(5) = 0$
; $Fib(1) = (phi^{1} - psi^{1})/ \sqrt(5) = 1$

; Done. 
; Assume that Fib(n-1) and Fib(n-2) are true,
; prove for n:
; $$Fib(n)=Fib(n-1)+Fib(n-2)$$
; $$=\frac{(\phi^{n-1}-\psi^{n-1})}{\sqrt{5}}+\frac{(\phi^{n-2}-\psi^{n-2})}{\sqrt{5}}$$

; $$=\frac{(\phi+1)\phi^{n-2}-(\psi+1)\psi^{n-2}}{\sqrt{5}}$$

; Due to $\phi^{2}=\phi+1$, $\psi^{2}=\psi+1$
; $$Fib(n)=\frac{\phi^{n}-\psi^{n}}{\sqrt{5}}$$

; notice psi is between 0 and -1, so when n grows largely, 
; Fib(n) will be approximated to $phi^{n}/\sqrt{5}$

