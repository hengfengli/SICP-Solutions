#lang scheme

(require rnrs/base-6)
(require rnrs/mutable-pairs-6)


(define (front-ptr queue) (car queue))
(define (rear-ptr queue) (cdr queue))

(define (set-front-ptr! queue item) (set-car! queue item))
(define (set-rear-ptr! queue item) (set-cdr! queue item))

(define (make-deque) (cons '() '()))

(define (empty-deque? queue) (null? (front-ptr queue)))

(define (front-deque queue)
  (if (empty-deque? queue)
      (error "FRONT called with an empty queue" queue)
      (car (front-ptr queue))))

(define (rear-deque queue)
  (if (empty-deque? queue)
      (error "REAR called with an empty queue" queue)
      (car (rear-ptr queue))))

(define (front-insert-deque! queue item)
  (let ((new-pair (cons item (cons '() '()))))
    (cond ((empty-deque? queue)
           (set-front-ptr! queue new-pair)
           (set-rear-ptr! queue new-pair)
           queue)
          (else
           (set-cdr! (cdr new-pair) (front-ptr queue))
           (set-car! (cdr (front-ptr queue)) new-pair) 
           (set-front-ptr! queue new-pair)
           queue))))

(define (rear-insert-deque! queue item)
  (let ((new-pair (cons item (cons '() '()))))
    (cond ((empty-deque? queue)
           (set-front-ptr! queue new-pair)
           (set-rear-ptr! queue new-pair)
           queue)
          (else
           (set-cdr! (cdr (rear-ptr queue)) new-pair)
           (set-car! (cdr new-pair) (rear-ptr queue))
           (set-rear-ptr! queue new-pair)
           queue))))

(define (front-delete-deque! queue)
  (cond ((empty-deque? queue)
         (error "FRONT DELETE! called with an empty queue" queue))
        (else
         (set-front-ptr! queue (cddr (front-ptr queue)))
         queue)))

(define (rear-delete-deque! queue)
  (cond ((empty-deque? queue)
         (error "REAR DELETE! called with an empty queue" queue))
        (else
         (let ((prev-pair (car (cdr (rear-ptr queue)))))
           (set-cdr! (cdr prev-pair) '())
           (set-rear-ptr! queue prev-pair)
           queue))))

; print the list in a nice way
(define (print-deque deque)
  (define (make-printable-list q)
    (if (null? q)
        '()
        (cons (car q)
              (make-printable-list (cddr q)))))
  (newline)
  (display (make-printable-list (front-ptr deque))))


(define q1 (make-deque))
(print-deque (rear-insert-deque! q1 'a))
(print-deque (rear-insert-deque! q1 'b))
(print-deque (front-insert-deque! q1 'c))
(print-deque (front-insert-deque! q1 'd))

(print-deque (front-delete-deque! q1))
(print-deque (rear-delete-deque! q1))
(print-deque (rear-delete-deque! q1))
(print-deque (rear-insert-deque! q1 'b))
(print-deque (front-insert-deque! q1 'a))