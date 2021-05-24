#lang adjutor/racket/base/minus

(require gregor
         gregor/period
         racket/match
         racket/contract
         "computus-paschalis.rkt")

(provide (contract-out
          [year->advent-start
           (-> exact-positive-integer?
               (and/c date? sunday?))]
          [year->christmas
           (-> exact-positive-integer?
               date?)]
          [year->epiphany
           (-> exact-positive-integer?
               date?)]
          [year->candlemas
           (-> exact-positive-integer?
               date?)]
          [year->ash-wednesday
           (-> exact-positive-integer?
               (and/c date? wednesday?))]
          [year->easter
           (-> exact-positive-integer?
               (and/c date? sunday?))]
          [year->ascension-thursday
           (-> exact-positive-integer?
               (and/c date? thursday?))]
          [year->pentecost
           (-> exact-positive-integer?
               (and/c date? sunday?))]
          [year->trinity-sunday
           (-> exact-positive-integer?
               (and/c date? sunday?))]
          ))

(define (year->easter y)
  (define-values [m d]
    (year->easter/values y))
  (date y m d))

(define (year->ascension-thursday y)
  (+days (year->easter y) 39))

(define (year->pentecost y)
  (+days (year->easter y) 49))

(define (year->trinity-sunday y)
  (+weeks (year->pentecost y) 1))

(define (year->ash-wednesday y)
  (-days (year->easter y)
         (+ (* 7 6) ;; 5 Sundays of Lent + Palm Sunday
            4)))

(define (year->septuagesima y)
  (-weeks (year->easter y) 9))
(define (year->sexagesima y)
  (-weeks (year->easter y) 8))
(define (year->quinquagesima y)
  (-weeks (year->easter y) 7))
(define (year->quadragesima y)
  (-weeks (year->easter y) 6))

(define (year->christmas y)
  (date y 12 25))

(define (year->advent-start y)
  (define xmas (year->christmas y))
  (match (->wday xmas)
    [0
     (-weeks xmas 4)]
    [wday
     (-days xmas (+ wday (* 7 3)))]))

(define (year->epiphany y)
  (date y 1 6))

(define (year->candlemas y)
  (date y 2 2))
