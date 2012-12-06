#lang scheme
(define (make-leaf symbol weight)
  (list 'leaf symbol weight))
(define (leaf? object)
  (eq? (car object) 'leaf))
(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))


(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

(define (left-branch tree) (car tree))
(define (right-branch tree) (cadr tree))
(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))  ; a simple list
      (caddr tree)))
(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

;;;
(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair)    ; symbol
                               (cadr pair))  ; frequency
                    (make-leaf-set (cdr pairs))))))
;;;;

; (define x1 (list (list 'A 4) (list 'C 1) (list 'B 2) (list 'D 1)))
; (make-leaf-set x1)

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge ordered-pairs)
  (if (null? (cdr ordered-pairs))
      (car ordered-pairs)
      (successive-merge (adjoin-set (make-code-tree (car ordered-pairs)
                                                    (cadr ordered-pairs))
                                    (cddr ordered-pairs)))))

; (generate-huffman-tree x1)
;;; encode

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (encode-symbol symbol tree)
  (cond ((and (leaf? tree) (eq? (symbol-leaf tree) symbol)) '())
        ((element-of-set? symbol (symbols (left-branch tree)))
         (append (list '0) (encode-symbol symbol (left-branch tree))))
        ((element-of-set? symbol (symbols (right-branch tree)))
         (append (list '1) (encode-symbol symbol (right-branch tree))))
        (else (error "The symbol is not in the tree at all."))))

(define x1 (list (list 'a 2) (list 'na 16)
                 (list 'boom 1) (list 'sha 3)
                 (list 'get 2) (list 'yip 9)
                 (list 'job 2) (list 'wah 1)))

(define song-tree (generate-huffman-tree x1))
(length (encode '(get a job
              sha na na na na na na na na
              get a job
              sha na na na na na na na na
              wah yip yip yip yip yip yip yip yip yip
              sha boom) song-tree))

; a. 84 bits
; b. 3*12*3 = 108 bits