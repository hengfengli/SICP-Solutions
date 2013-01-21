#lang scheme
;;; review 'type-tag'
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

;;; review 'apply-generic'
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (error
            "No method for these types -- APPLY-GENERIC"
            (list op type-tags))))))

;;; generic selectors
(define (real-part z) (apply-generic 'real-part z))
(define (imag-part z) (apply-generic 'imag-part z))
(define (magnitude z) (apply-generic 'magnitude z))
(define (angle z) (apply-generic 'angle z))

;;; it needs to put thie operation into table
;;; for complex number.
(put 'real-part '(complex) real-part)
(put 'imag-part '(complex) imag-part)
(put 'magnitude '(complex) magnitude)
(put 'angle '(complex) angle)

;;; z = (cons 'complex (cons 'rectanglar (cons 3 4)))
;;; trace through all the procedures.
;;; 'apply-generic' is invoked twice.
(magnitude (cons 'complex (cons 'rectanglar (cons 3 4))))
(apply-generic 'magnitude (cons 'complex (cons 'rectanglar (cons 3 4))))  
;;; remove 'complex
(magnitude (cons 'rectanglar (cons 3 4)))
(apply-generic 'magnitude (cons 'rectanglar (cons 3 4)))
;;; remove 'rectanglar
(magnitude (cons 3 4))
;;; 'magnitude' in the definition of rectangular-package
(sqrt (+ (square (real-part (cons 3 4)))
         (square (imag-part (cons 3 4)))))