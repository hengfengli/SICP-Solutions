#lang scheme

(require rnrs/base-6)
(require rnrs/mutable-pairs-6)

; code on textbook
(define (front-ptr queue) (car queue))
(define (rear-ptr queue) (cdr queue))

(define (set-front-ptr! queue item) (set-car! queue item))
(define (set-rear-ptr! queue item) (set-cdr! queue item))

(define (empty-queue? queue) (null? (front-ptr queue)))

(define (make-queue) (cons '() '()))

(define (front-queue queue)
  (if (empty-queue? queue)
      (error "FRONT called with an empty queue" queue)
      (car (front-ptr queue))))

(define (insert-queue! queue item)
  (let ((new-pair (cons item '())))
    (cond ((empty-queue? queue)
           (set-front-ptr! queue new-pair)
           (set-rear-ptr! queue new-pair)
           queue)
          (else
           (set-cdr! (rear-ptr queue) new-pair)
           (set-rear-ptr! queue new-pair)
           queue))))

(define (delete-queue! queue)
  (cond ((empty-queue? queue)
         (error "DELETE! called with an empty queue" queue))
        (else
         (set-front-ptr! queue (cdr (front-ptr queue)))
         queue)))

(define (print-queue queue)
  (front-ptr queue))
  

(define q1 (make-queue))
(print-queue (insert-queue! q1 'a))

(print-queue (insert-queue! q1 'b))

(print-queue (delete-queue! q1))
(print-queue (delete-queue! q1))

; when you insert a new point to an empty queue, 
; the rear pointer will be rewritten. So it doesn't 
; matter to delete the rear pointer when the queue 
; becomes empty. 
(print-queue (insert-queue! q1 'c))
            
            












            
            