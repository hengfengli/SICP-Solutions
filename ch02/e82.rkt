#lang racket

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (try-coercion op args type-tags)))))

(define reduce
     (lambda (f L n)
          (if (null? L)
               n
               (f (head L) (reduce f (tail L) n)))))

; Test whether all types can be coerced to the
; target type
(define (coerce-all-to-one? types target-type)
  (foldr (lambda (t acc) 
           (if (equal? t target-type)
               acc
               (and (get-coercion t target-type) acc)))
         #t
         types))

; Attempt to coerce all the arguments to the 
; type of the first argument, then to the type
; of the second argument, and so on. (If it is 
; written as an internal function, which would 
; be much simpler without too much parameters.)
(define (iter-coerce op test-types types args)
  (if (null? test-types)
      (error "No method for these types"
             (list op type-tags))
      (let ((target-type (car test-types)))
        ; Can all types be coerced to the target type?
        (if (coerce-all-to-one? types target-type)
            ; Yes, then coerce all arguments.
            (let ((new-args (map (lambda (a)
                                   (if (equal? (type-tag a) target-type)
                                       a
                                       ((get-coercion (type-tag a) target-type) a)))
                                 args)))
              (apply-generic op new-args))
            ; No, try next type of arguments.
            (iter-coerce op (cdr test-types) types args)))))

(define (try-coercion op args type-tags)
  (iter-coerce op type-tags type-tags args))