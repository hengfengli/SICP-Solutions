#lang racket

; integer -> rational
(put 'raise 'integer
     (lambda (n)
       (make-rational n 1)))

; rational -> real
(put 'raise 'rational
     (lambda (n)
       (make-scheme-number (/ (car x) (cdr x)))))

(define (raise n)
  (apply-generic 'raise n))

(define (raise-to a1 a2)
  (if (null? a1)
      ; If a1 becomes null, it means
      ; that it cannot be raised any more 
      ; in the tower.
      null 
      (if (equal? (type-tag a1) (type-tag a2)) 
          a1
          (raise-to (raise a1) a2))))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (= (length args) 2)
              (let ((a1 (car args))
                    (a2 (cadr args)))
                (let ((raised_a1 (raise-to a1 a2))
                      (raised_a2 (raise-to a2 a1)))
                  (cond (raised_a1
                         (apply-generic op raised_a1 a2))
                        (raised_a2
                         (apply-generic op a1 raised_a2))
                        (else
                         (error "No method for these types"
                                (list op type-tags))))))
              ; If cannot find the procedure, like get 'raise 'complex
              ; then return null
              null)))))

; There is a problem with above way. For example, t1->t2->t3, t4->t3, 
; if the types of input are t1 and t4, they cannot be computed because
; they cannot be raised to t3 at the same time.

; A better way is to find the common higher type for both two arguments.
; One way to do this is that trying to raise t1 to every higher types of 
; t2 in the tower.