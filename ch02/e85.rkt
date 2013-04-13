#lang scheme

(put 'project 'complex
     (lambda (n)
       (make-real (real-part n))))

(put 'project 'scheme-number
     (lambda (n)
       (let ((num-rat (inexact->exact n)))
         (make-rational (numer num-rat)
                        (denom num-rat)))))

(put 'project 'rational
     (lambda (n)
       (make-scheme-number (floor (/ (numer n) (denom n))))))

(define (project n)
  (apply-generic 'project n))

; A drop procedure that drops an object as far as possible. 
(define (drop x)
  (let ((project-op (get 'project (type-tag x))))
    (if project-op
        (let ((lowering (project-op (content x))))
          ; equ? from e2.79
          (if (equ? x (raise lowering))
              (drop lowering)
              x))
        x)))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          ; simplifies the answer
          (drop (apply proc (map contents args)))
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
