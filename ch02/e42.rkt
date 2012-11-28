#lang scheme
(define nil '())
(define (enumerate-interval low high)
  (if (> low high)
      nil
      (cons low (enumerate-interval (+ low 1) high))))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

;;;;;;;;;;;;;;;;;;;;;;;;

(define empty-board nil)
(define (make-position row col)
  (cons row col))

(define (adjoin-position new-row k rest-of-queens) 
  (cons (make-position new-row k) rest-of-queens))

(define (safe? k positions)
  (let ((k-position (car (filter (lambda (x) (= k (cdr x)))
                                 positions)))
        (others (filter (lambda (x) (not (= k (cdr x))))
                        positions)))
    (= 0 (length (filter (lambda (x)
                      (let ((row-x (car x))
                            (col-x (cdr x))
                            (row-k (car k-position))
                            (col-k (cdr k-position))
                            (diff-col (- (cdr k-position) (cdr x))))
                       (or (= (car x) (car k-position))    ; no-safe cases
                           (= row-k (+ row-x diff-col))
                           (= row-k (- row-x diff-col)))))
                    others)))))


; test
(define k-1 (make-position 3 1))
(define k-2 (make-position 7 2))
(define k-3 (make-position 2 3))
(define k-4 (make-position 8 4))
(define k-5 (make-position 5 5))
(define k-6 (make-position 1 6))
(define k-7 (make-position 4 7))
(define k-8 (make-position 6 8))
(define test-positions (list k-1 k-2 k-3 k-4 k-5 k-6 k-7 k-8))
(safe? 8 test-positions)


(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) 
           (safe? k positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1)))))) ; safe previous solutions
  (queen-cols board-size))

; solved!
(queens 8)