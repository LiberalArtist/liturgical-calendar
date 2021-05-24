#lang info

(define pkg-name "liturgical-calendar")
(define collection "liturgical-calendar")
(define pkg-desc "Calculate movable feasts on the Gregorian calendar")
(define version "0.0")
(define pkg-authors '(philip))

;; Documentation
(define scribblings
  '(("scribblings/liturgical-calendar.scrbl" ())))

;; Dependencies
(define deps
  '("base"
    "adjutor"
    "typed-racket-lib"
    "gregor-lib"))

(define build-deps
  '("scribble-lib"
    "racket-doc"
    "adjutor"
    "gregor-doc"
    "at-exp-lib"
    "rackunit-lib"))

