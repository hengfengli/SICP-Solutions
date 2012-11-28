#lang racket
(flatmap
 (lambda (new-row)
   (map (lambda (rest-of-queens)
          (adjoin-position new-row k rest-of-queens))
        (queen-cols (- k 1))))
 (enumerate-interval 1 board-size))

; In Louis' solution, the queen-cols will be executed board-size times, 
; which makes the program run so slowly. In the 2.42, the outside 'queen-cols'
; function will be called just once.

; If the 2.42 program solves the puzzle in time T, Louis' program will be in T*T
; because the queen-cols is recursive call, which will lead to board-size times calls.