#lang scheme

; a. It will fall into a infinite loop, because after calling coercion, it calls 
; 'apply-generic' with two complex numbers again. 

; b. Louis' way is not right and apply-generic works fine. However, doing coeriion 
; with two same types is kind of redundant, and we can find a way to fix it.

; c. 

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (= (length args) 2)
              (let ((type1 (car type-tags))
                    (type2 (cadr type-tags))
                    (a1 (car args))
                    (a2 (cadr args)))
                (if (not (equal? type1 type2))
                    (let ((t1->t2 (get-coercion type1 type2))
                          (t2->t1 (get-coercion type2 type1)))
                      (cond (t1->t2
                             (apply-generic op (t1->t2 a1) a2))
                            (t2->t1
                             (apply-generic op a1 (t2->t1 a2)))
                            (else
                             (error "No method for these types"
                                    (list op type-tags)))))
                    (error "No method for these types"
                                    (list op type-tags))))
              (error "No method for these types"
                     (list op type-tags)))))))

