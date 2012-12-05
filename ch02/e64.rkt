#lang scheme

(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result (partial-tree (cdr non-left-elts)
                                              right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts (cdr right-result)))
                (cons (make-tree this-entry left-tree right-tree)
                      remaining-elts))))))))

; (partial-tree (1 3 5 7 9 11) 6)
; left-size = 2
; left-result = (partial-tree elts 2)
; left-tree = (car left-result)
; non-left-elts = (cdr left-result)
; right-size = 3
; this-entry = (car non-left-elts)
; right-result = (partial-tree (cdr non-left-elts) right-size)
; right-tree = (car right-result)
; remaining-elts = (cdr right-result)

; (cons tree remaining-elts)

; a. Every partial-tree will split the ordered list into two parts and 
; one entry. The entry will become the root of the tree, and the left
; part becomes the left subtree and the right part becomes the right
; subtree.

; b. T(n) = 2 * T(n/2) + O(1) = O(n)