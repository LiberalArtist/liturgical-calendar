#lang typed/racket

(require (for-syntax syntax/parse))

;; macro so the code looks like the presentation in Meeus and Bien
(define-syntax (divide/by/quotient/remainder stx)
  (define-splicing-syntax-class clause-head
    #:description #f
    #:attributes {dividend divisor}
    (pattern (~seq dividend:expr
                   #:/ divisor:exact-positive-integer
                   #:->)))
  (define-syntax-class clause
    #:attributes {parsed}
    (pattern [:clause-head (~literal _) r:id]
             #:fail-when (and (free-identifier=? #'r #'_) #'r)
             "either quotient or remainder must not be _"
             #:with parsed #'[{r} (remainder dividend divisor)])
    (pattern [:clause-head q:id (~literal _)]
             #:with parsed #'[{q} (quotient dividend divisor)])
    (pattern [:clause-head q:id r:id]
             #:with parsed #'[{q r} (quotient/remainder dividend divisor)]))
  (syntax-parse stx
    #:track-literals
    [(_ bind:clause
        ...
        #:then
        body:expr ...+)
     #`(let*-values (bind.parsed ...)
         body ...)]))

(define (year->easter/values [x : Positive-Integer])
  ;; these could maybe use fixnums after handling x
  (divide/by/quotient/remainder
   [                                 x #:/  19 #:-> _ a]
   [                                 x #:/ 100 #:-> b c]
   [                                 b #:/   4 #:-> d #{e : Byte}]
   [                           (+ 8 b) #:/  25 #:-> f _]
   [                     (+ b (- f) 1) #:/   3 #:-> g _]
   [     (+ (* 19 a) b (- d) (- g) 15) #:/  30 #:-> _gsbbgs #{h : Fixnum}] ;; https://github.com/racket/typed-racket/issues/1039
   [                                 c #:/   4 #:-> i k] ;; yes, we skip j
   [(+ 32 (* 2 e) (* 2 i) (- h) (- k)) #:/   7 #:-> _ l]
   [           (+ a (* 11 h) (* 22 l)) #:/ 451 #:-> m _]
   [              (+ h l (* -7 m) 114) #:/  31 #:-> n p]
   #:then
   (values n
           (add1 p))))
