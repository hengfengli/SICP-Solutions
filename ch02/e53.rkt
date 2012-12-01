#lang scheme
(car '(a b c))
(cdr '(a b c))

(define (memq item x)
  (cond ((null? x) false)
        ((eq? item (car x)) x)
        (else (memq item (cdr x)))))

(memq 'apple '(pear banana prune))
(memq 'apple '(x (apple sauce) y apple pear))

(list 'a 'b 'c)
(list (list 'george))
'((x1 x2) (y1 y2))
(cdr '((x1 x2) (y1 y2)))

(cadr '((x1 x2) (y1 y2)))
(pair? (car '(a short list)))

(memq 'red '((red shoes) (blue socks)))
(memq 'red '(red shoes blue socks))

