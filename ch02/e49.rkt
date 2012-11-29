#lang scheme
(define (make-vect x y)
  (cons x y))

(define xcor-vect car)
(define ycor-vect cdr)

(define (add-vect v1 v2)
  (make-vect (+ (xcor-vect v2)
                (xcor-vect v2))
             (+ (ycor-vect v1)
                (ycor-vect v2))))

(define (sub-vect v1 v2)
  (make-vect (- (xcor-vect v1)
                (xcor-vect v2))
             (- (ycor-vect v1)
                (ycor-vect v2))))

(define (scale-vect s v)
  (make-vect (* s (xcor-vect v))
             (* s (ycor-vect v))))

; 2.48
(define (make-segment start-v end-v)
  (cons start-v end-v))

(define start-segment car)
(define end-segment cdr)


(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (origin-frame frame)
  (car frame))

(define (edge1-frame frame)
  (car (cdr frame)))

(define (edge2-frame frame)
  (car (cdr (cdr frame))))


(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
     (origin-frame frame)
     (add-vect (scale-vect (xcor-vect v)
                           (edge1-frame frame))
               (scale-vect (ycor-vect v)
                           (edge2-frame frame))))))

(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (draw-line
        ((frame-coord-map frame) (start-segment segment))
        ((frame-coord-map frame) (end-segment segment))))
     segment-list)))

; 2.49
(define (draw-outline frame)
  (segments->painter 
   (list (make-segment (make-vect 0 0) (make-vect 0 1))
         (make-segment (make-vect 1 0) (make-vect 1 1))
         (make-segment (make-vect 1 1) (make-vect 0 1))
         (make-segment (make-vect 0 1) (make-vect 0 0)))) 
  frame)

(define (draw-x frame)
  (segments->painter 
   (list (make-segment (make-vect 0 0) (make-vect 1 1))
         (make-segment (make-vect 0 1) (make-vect 1 0)))) 
  frame)

(define (draw-diamond frame)
  (segments->painter 
   (list (make-segment (make-vect 0.5 0) (make-vect 1 0.5))
         (make-segment (make-vect 1 0.5) (make-vect 0.5 1))
         (make-segment (make-vect 0.5 1) (make-vect 0 0.5))
         (make-segment (make-vect 0 0.5) (make-vect 0.5 0))))
  frame)

; For the wave, the principle is as same as above.