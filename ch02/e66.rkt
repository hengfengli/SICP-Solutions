#lang scheme

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

(define (adjoin-set x set)
  (cond ((null? set) (make-tree x '() '()))
        ((= (key x) (key (entry set))) set)
        ((< (key x) (key (entry set)))
         (make-tree (entry set)
                    (adjoin-set x (left-branch set))
                    (right-branch set)))
        ((> (key x) (key (entry set)))
         (make-tree (entry set)
                    (left-branch set)
                    (adjoin-set x (right-branch set))))))

(define (make-pair key value)
  (cons key value))

(define (key kv-pair) (car kv-pair))
(define (value kv-pair) (cdr kv-pair))

(define (lookup given-key tree)
  (cond ((null? tree) '())
        ((= given-key (key (entry tree))) (value (entry tree)))
        ((< given-key (key (entry tree))) (lookup given-key (left-branch tree)))
        ((> given-key (key (entry tree))) (lookup given-key (right-branch tree)))))

(define x1 (adjoin-set (make-pair 7 1) 
                       (adjoin-set (make-pair 3 2) 
                                   (adjoin-set (make-pair 2 3) 
                                               (adjoin-set (make-pair 1 4) 
                                                           (adjoin-set (make-pair 5 5) '()))))))

(lookup 1 x1)