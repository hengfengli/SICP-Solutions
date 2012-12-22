#lang scheme
(define (square x) (* x x))

(define (attach-tag type-tag contents)
  (cons type-tag contents))

(define (type-tag datum)
  (if (pair? datum)
      (car datum)
      (error "Bad tagged datum -- TYPE-TAG" datum)))

(define (contents datum)
  (if (pair? datum)
      (cdr datum)
      (error "Bad tagged datum -- CONTENTS" datum)))

(define (install-rectangular-package)
  ;; internal procedures
  (define (real-part z) (car z))
  (define (imag-part z) (cdr z))
  (define (make-from-real-imag x y) (cons x y))
  (define (magnitude z)
    (sqrt (+ (square (real-part z))
             (square (imag-part z)))))
  (define (angle z)
    (atan (imag-part z) (real-part z)))
  (define (make-from-mag-ang r a)
    (cons (* r (cos a)) (* r (sin a))))
  ;; interface to the rest of the system
  (define (tag x) (attach-tag 'rectangular x))
  (put 'real-part '(rectangular) real-part)
  (put 'imag-part '(rectangular) imag-part)
  (put 'magnitude '(rectangular) magnitude)
  (put 'angle '(rectangular) angle)
  (put 'make-from-real-imag 'rectangular
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'rectangular
       (lambda (r a) (tag (make-from-mag-ang r a))))
  'done)


(define (install-polar-package)
  ;; internal procedures
  (define (magnitude z) (car z))
  (define (angle z) (cdr z))
  (define (make-from-mag-ang r a) (cons r a))
  (define (real-part z)
    (* (magnitude z) (cos (angle z))))
  (define (imag-part z)
    (* (magnitude z) (sin (angle z))))
  (define (make-from-real-imag x y)
    (cons (sqrt (+ (square x) (square y)))
          (atan y x)))
  ;; interface to the rest of the system
  (define (tag x) (attach-tag 'polar x))
  (put 'real-part '(polar) real-part)
  (put 'imag-part '(polar) imag-part)
  (put 'magnitude '(polar) magnitude)
  (put 'angle '(polar) angle)
  (put 'make-from-real-imag 'polar
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'polar
       (lambda (r a) (tag (make-from-mag-ang r a))))
  'done)

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (error
            "No method for these types -- APPLY-GENERIC"
            (list op type-tags))))))

(define (real-part z) (apply-generic 'real-part z))
(define (imag-part z) (apply-generic 'imag-part z))
(define (magnitude z) (apply-generic 'magnitude z))
(define (angle z) (apply-generic 'angle z))

(define (make-from-real-imag x y)
  ((get 'make-from-real-imag 'rectangular) x y))
(define (make-from-mag-ang r a)
  ((get 'make-from-mag-ang 'polar) r a))

;; 2.73
(define (deriv exp var)
   (cond ((number? exp) 0)
         ((variable? exp) (if (same-variable? exp var) 1 0))
         (else ((get 'deriv (operator exp)) (operands exp)
                                            var))))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

; a.
; the "get 'deriv operator" will return a function 
; according to the given operator. There is no need
; to put number? and same-variable? into any dispatched
; functions, because these two functions do not need to
; dispatch any different type operators.

; b.
(define (install-deriv-package)
  ;; internal procedures
  (define (make-sum a1 a2) (list '+ a1 a2))
  (define (addend s) (car s))
  (define (augend s) (cadr s))
  
  (define (make-product m1 m2) (list '* m1 m2))
  (define (multiplier p) (car p))
  (define (multiplicand p) (cadr p))
  
  (define (deriv-sum exp-operands var)
    (make-sum (deriv (addend exp-operands) var)
              (deriv (augend exp-operands) var)))
  
  (define (deriv-product exp-operands var)
    (make-sum
           (make-product (multiplier exp-operands)
                         (deriv (multiplicand exp-operands) var))
           (make-product (deriv (multiplier exp-operands) var)
                         (multiplicand exp-operands))))
  ; c.
  (define (base p) (car p))
  (define (exponent p) (cadr p))
  (define (make-exponentiation b e)
    (cond ((=number? b 0) 1)
          ((=number? e 1) b)
          ((and (number? b) (number? e)) (expt b e))
          (else (list '** b e))))
  
  (define (deriv-expo exp-operands var)
    (make-product (make-product (exponent exp-operands)
                                (make-exponentiation (base exp-operands)
                                                     (- (exponent exp-operands) 1)))
                  (deriv (base exp-operands) var)))

  ;; interface to the rest of the system
  (put 'deriv '+ deriv-sum)
  (put 'deriv '* deriv-product)
  (put 'deriv '** deriv-expo)
  'done)

; d.
; Only need to change the interfaces that the order of put's parameters.