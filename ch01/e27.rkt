#lang scheme
; There are some numbers which can fool Fermat test.
; 
; This concept makes me remember stuff about false positive 
; and false negative.
; 
; Let me review it:
; "Basically, a false positive is a data instance where the 
; model we've created predicts it should be positive, but 
; instead, the actual value is negative. Conversely, a false
; negative is a data instance where the model predicts it should
; be negative, but the actual value is positive."

; For an Email spam detector, which one is more important?
; The answer is false negative, because we don't want to miss
; any normal email. Occasionally, it is fine that there are some
; spam emails in our inbox.

; This book gives some numbers to fool Fermat test, like 561,1105,
; 1729，2465,2821,6601. There are 255 such numbers in 100,000,000. 