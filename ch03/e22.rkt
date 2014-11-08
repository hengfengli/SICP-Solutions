#lang scheme

(require rnrs/base-6)
(require rnrs/mutable-pairs-6)

; local state
; front-ptr keepts all elements in the queue
; rear-ptr is just a pointer at the last element
(define (make-queue)
  (let ((front-ptr '())
        (rear-ptr '()))
    ; <definitions of internal procedures>
    (define (print-queue)
      (display front-ptr)
      (newline))
    
    (define (empty-queue?)
      (null? front-ptr))
    
    (define (front-queue)
      (if (empty-queue?)
          (error "FRONT called with an empty queue")
          (car front-ptr)))
    
    (define (rear-queue)
      (if (empty-queue?)
          (error "REAR called with an empty queue")
          (car rear-ptr)))
    
    (define (insert-queue! item)
      (let ((new-pair (cons item '())))
        (cond ((empty-queue?)
               (set! front-ptr new-pair)
               (set! rear-ptr new-pair))
              (else
               (set-cdr! rear-ptr new-pair)
               (set! rear-ptr new-pair)))))
    
    (define (del-q!)
      (cond ((empty-queue?)
             (error "DELETE! called with an empty queue"))
            (else
             (set! front-ptr (cdr front-ptr)))))
    
    (define (dispatch m)
      (cond ((eq? m 'insert-queue!) insert-queue!)
            ((eq? m 'delete-queue!) del-q!)
            ((eq? m 'front-queue) front-queue)
            ((eq? m 'rear-queue) rear-queue)
            ((eq? m 'empty-queue?) empty-queue?)
            ((eq? m 'print-queue) print-queue)
            (else (error "Undefined operation -- MAKE-QUEUE" m))))
    
    dispatch))

(define (insert-queue! queue item)
  ((queue 'insert-queue!) item)
  queue)
(define (delete-queue! queue)
  ((queue 'delete-queue!))
  queue)
(define (empty-queue? queue)
  ((queue 'empty-queue?)))
(define (front-queue queue)
  ((queue 'front-queue)))
(define (rear-queue queue)
  ((queue 'rear-queue)))
(define (print-queue queue)
  ((queue 'print-queue)))

(define q1 (make-queue))

(print-queue q1)

(print-queue (insert-queue! q1 'a))

(print-queue (insert-queue! q1 'b))

(print-queue (insert-queue! q1 'c))

(front-queue q1)
(rear-queue q1)

(empty-queue? q1)

(print-queue (delete-queue! q1))
(print-queue (delete-queue! q1))
(print-queue (delete-queue! q1))

(empty-queue? q1)