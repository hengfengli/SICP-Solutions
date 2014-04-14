#lang racket

(define (make-account balance secret-password)
  (define wrong-input-counter 0)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch input-password m)
    (if (not (eq? input-password secret-password))
        (begin (set! wrong-input-counter (+ wrong-input-counter 1))
               (if (eq? wrong-input-counter 4)
                   (error "call-the-cops")
                   (error "Incorrect password")))
        (begin (set! wrong-input-counter 0)
               (cond ((eq? m 'withdraw) withdraw)
                     ((eq? m 'deposit) deposit)
                     (else (error "Unknown request -- MAKE-MONITORED"
                                  m))))))
  dispatch)


; E3.7
(define (make-joint current-acc current-pass new-pass)
  (define (dispatch input-pass m)
    (if (not (eq? input-pass new-pass))
        (error "Incorrect password")
        (current-acc current-pass m)))
  dispatch)

(define peter-acc (make-account 100 'open-sesame))

(define paul-acc (make-joint peter-acc 'open-sesame 'rosebud))

