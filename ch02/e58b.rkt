#lang scheme
; e2.58 b - referenced from http://community.schemewiki.org/?sicp-ex-2.58

(define (memq item x)
  (cond ((null? x) false)
        ((eq? item (car x)) x)
        (else (memq item (cdr x)))))

(define (operation expr) 
  (if (memq '+ expr) 
      '+ 
      '*))

; eymbolic differentiation
(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

; (define (make-sum a1 a2) (list '+ a1 a2))
(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list a1 '+ a2))))

; (define (make-product m1 m2) (list '* m1 m2))
(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list m1 '* m2))))

(define (sum? expr) 
  (eq? '+ (operation expr)))

(define (single-or-list expr)
  (if (= (length expr) 1)
      (car expr)
      expr))

(define (before-op-iter expr previous op)
  (if (eq? (car expr) op)
      previous
      (before-op-iter (cdr expr) (append previous (list (car expr))) op)))

; find the previous part before '+
(define (addend expr)
  (single-or-list (before-op-iter expr '() '+)))

(define (augend expr) 
   (single-or-list (cdr (memq '+ expr))))

(define (product? expr) 
   (eq? '* (operation expr))) 

; find the previous part before '*
(define (multiplier expr)
  (single-or-list (before-op-iter expr '() '*)))

(define (multiplicand expr) 
  (single-or-list (cdr (memq '* expr))))

; e2.56
(define (exponentiation? x)
  (and (pair? x) (eq? (car x) '**)))

(define (base p) (cadr p))
(define (exponent p) (caddr p))
(define (make-exponentiation b e)
    (cond ((=number? b 0) 1)
          ((=number? e 1) b)
          ((and (number? b) (number? e)) (expt b e))
          (else (list '** b e))))

; compute the derivative
(define (deriv exp var)
  (display exp)
  (newline)
  (display '========)
  (newline)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((exponentiation? exp)
         (make-product (make-product (exponent exp)
                                     (make-exponentiation (base exp) (- (exponent exp) 1)))
                       (deriv (base exp) var)))
        ((product? exp)
         (make-sum
           (make-product (multiplier exp)
                         (deriv (multiplicand exp) var))
           (make-product (deriv (multiplier exp) var)
                         (multiplicand exp))))
        (else
         (error "unknown expression type -- DERIV" exp))))

; (deriv '(x + 3 * (x + y + 2)) 'x)
(deriv '(x + 3 * (x + y + 2) + x) 'x)