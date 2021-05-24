#lang racket

(require (for-syntax syntax/parse))

(provide year->easter/values)

(module+ test
  (require rackunit
           gregor))
(module+ test
  (define-simple-check (check-easter y m d)
    (unless (sunday? (date y m d))
      (fail-check "not a date"))
    (define-values [m* d*] (year->easter/values y))
    (and (= m m*) (= d d*)))
  (define (year->easter/pair year)
    (call-with-values (λ () (year->easter/values year))
                      cons))
  ;; tests from Meeus p. 68
  (check-easter 1991 3 31)
  (check-easter 1992 4 19)
  (check-easter 1993 4 11)
  (check-easter 1954 4 18)
  (check-easter 2000 4 23)
  (check-easter 1818 3 22)
  (check-easter 2285 3 22) ;; earliest easter
  (check-easter 1886 4 25) ;; latest easter
  (check-easter 1943 4 25) ;; latest easter
  (check-easter 2038 4 25) ;; latest easter
  #||#)

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

(define (year->easter/values x) ;; x is positive or we get easters out of bounds
  ;; Meeus
  ;; sign makes it hard to get fixnum arithmetic specialization
  (divide/by/quotient/remainder
   [                                 x #:/  19 #:-> _ a]
   [                                 x #:/ 100 #:-> b c]
   [                                 b #:/   4 #:-> d e]
   [                           (+ 8 b) #:/  25 #:-> f _]
   [                     (+ b (- f) 1) #:/   3 #:-> g _]
   [     (+ (* 19 a) b (- d) (- g) 15) #:/  30 #:-> _ h]
   [                                 c #:/   4 #:-> i k] ;; yes, no j
   [(+ 32 (* 2 e) (* 2 i) (- h) (- k)) #:/   7 #:-> _ l]
   [           (+ a (* 11 h) (* 22 l)) #:/ 451 #:-> m _]
   [              (+ h l (* -7 m) 114) #:/  31 #:-> n p]
   #:then
   (values n
           (add1 p))))
#|
(define (gauß yr)
  (let* ([a (remainder yr 19)]
         [b (remainder yr 4)]
         [c (remainder yr 7)]
         [k (quotient yr 100)]
         [p (quotient (+ 13 (* 8 k)) 25)]
         [q (quotient k 4)]
         [M (remainder (+ 15 (- p) k (- q))
                       30)]
         [N (remainder (+ 4 k (- q))
                       

|#  
