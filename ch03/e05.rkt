#lang racket

(define (square x) (* x x))

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))

(define (make-P-test x1 x2 y1 y2 cX cY radius)
  (lambda()
    (let ((randX (random-in-range x1 x2))
          (randY (random-in-range y1 y2)))
      (let ((dist-to-center (sqrt (+ (square (- randX cX)) 
                                     (square (- randY cY))))))
        (<= dist-to-center radius)))))   

(define (monte-carlo trails experiment)
  (define (iter trials-remaining trails-passed)
    (cond ((= trials-remaining 0)
           (/ trails-passed trails))
          ((experiment)
           (iter (- trials-remaining 1) (+ trails-passed 1)))
          (else
           (iter (- trials-remaining 1) trails-passed))))
  (exact->inexact (iter trails 0)))

(define P-test (make-P-test 2 8 4 10 5 7 3))

(define estimate-area (monte-carlo 1000 P-test))

estimate-area