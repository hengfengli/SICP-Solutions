#lang scheme
(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (make-interval a b) (cons a b))

; 2.7
(define (upper-bound z) (cdr z))
(define (lower-bound z) (car z))

; 2.8
(define (sub-interval x y)
  (add-interval x
                (make-interval (min (- (lower-bound y)) 
                                    (- (upper-bound y)))
                               (max (- (lower-bound y))
                                    (- (upper-bound y))))))

(define (width z)
  (/ (- (upper-bound z) (lower-bound z)) 2))


; 2.10
(define (div-interval x y)
  (if (and (>= (upper-bound y) 0)
           (<= (lower-bound y) 0))
      (error "Spaning zero")
      (mul-interval x
                    (make-interval (/ 1.0 (upper-bound y))
                                   (/ 1.0 (lower-bound y))))))



(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))

(define (make-center-percent c tolerance)
  (let ((wd (* (/ tolerance 100) c)))
    (make-center-width c wd)))

; 2.14
(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))
(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval one
                  (add-interval (div-interval one r1)
                                (div-interval one r2)))))

(define z1 (make-interval 2 10))
(define z2 (make-interval 3 5))

(par1 z1 z2)
(par2 z1 z2)

(div-interval z1 z1)
(div-interval z1 z2)

(define z3 (make-center-percent 5 0.1))
(define z4 (make-center-percent 10 0.1))

(div-interval z3 z4)
(div-interval z3 z3)

(par1 z3 z4)
(par2 z3 z4)

(div-interval z3 z3)

;  R1*R2/(R1+R2)
;= 1 / ((R1/R1*R2) + (R2/R1*R2))
; however, R1/R1 and R2/R2 do not equal to 1
; e.g., (div-interval z3 z3) = (0.9980019980019981 . 1.002002002002002)
; so the tranformation can not be totally identical. 