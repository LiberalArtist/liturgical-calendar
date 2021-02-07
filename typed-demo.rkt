#lang typed/racket

(require syntax/parse/define)

(define (year->easter/values [x : Positive-Integer])
  ;; Algorithm:
  ;;   - Jean Meeus, "Astronomical Algorithms," 2nd ed.,
  ;;     (Richmond: Willmann-Bell, 1998),
  ;;     chapter 8, "Date of Easter," pp. 67--68
  ;;   - Reinhold Bien, "Gauß and Beyond: The Making of Easter Algorithms,"
  ;;     Arch. Hist. Exact Sci. 58, 439–452 (2004),
  ;;     table 9, "Algorithm of an anonymous correspondent," p. 451,
  ;;     <https://doi.org/10.1007/s00407-004-0078-5>
  ;;
  ;; The macro lets the implementation obviously match
  ;; the presentation by Meeus and Bien.
  (divide/by/quotient/remainder
   [                                 x #:/  19 #:-> _ a]
   [                                 x #:/ 100 #:-> b c]
   [                                 b #:/   4 #:-> d #{e : Byte}]
   [                           (+ 8 b) #:/  25 #:-> f _]
   [                     (+ b (- f) 1) #:/   3 #:-> g _]
   [     (+ (* 19 a) b (- d) (- g) 15) #:/  30 #:-> _ h]
   [                                 c #:/   4 #:-> i k] ;; yes, we skip j
   [(+ 32 (* 2 e) (* 2 i) (- h) (- k)) #:/   7 #:-> _ l]
   [           (+ a (* 11 h) (* 22 l)) #:/ 451 #:-> m _]
   [              (+ h l (* -7 m) 114) #:/  31 #:-> n p]
   #:then
   (values n
           (add1 p))))

(define-simple-macro (divide/by/quotient/remainder
                      [dividend:expr #:/ divisor:expr #:-> q:id r:id]
                      ...
                      #:then
                      body:expr ...+)
  (match-let*-values ([{q r}
                       (quotient/remainder dividend divisor)]
                      ...)
    body ...))
