#lang scheme
; Explicit dispatch:
;       add new types: we need to implement all existing operations of this 
;                      data object (consider the name conflict).
;  add new operations: we need to add the new operations into all types of this 
;                      data object.

; Data-directed:
;       add new types: we need to create an install package and register this data
;                      objects's accessor methods (we need to speicify the type's name).
;  add new operations: we register the new operations into the table.

; Message-passing:
;       add new types: we just need to create a procedure which returns a 
;                      dispatch procedure that receive the requested operations on
;                      this data object. (adding new types without the need to specify 
;                      type's name).
;  add new operations: we just need to add a branch to all types of this data object.


; The message passing style is most appropriate
; for a system in which new types must often
; be added. 
; (calling methods without specifying the type's name. So when the types is changed, 
; the upper level does not be affected.)

; The data-directed style is most appropriate 
; for a system in which new operations must often
; be added.
; (a operations table is easy to manage the new added operations.)