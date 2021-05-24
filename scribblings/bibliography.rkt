#lang at-exp racket

(require scriblib/autobib)

(provide ~cite
         citet
         generate-bibliography
         in-bib
         bien
         wallis
         meeus)

(define-cite ~cite citet generate-bibliography)


;(in-bib orig where)

(define bien
  (make-bib
   #:title "Gauß and Beyond: The Making of Easter Algorithms"
   #:author "Reinhold Bien"
   #:date 2004
   #:location (journal-location "Archive for History of Exact Sciences"
                                #:volume 58
                                #:number 5
                                #:pages '(439 452))
   #:url "https://doi.org/10.1007/s00407-004-0078-5"))

(define wallis
  (make-bib
   #:author "Faith Wallis"
   #:title "Introduction, appendices, and commentary"
   #:date 1999
   #:url
   "https://isidore.co/calibre/#book_id=7150&library_id=CalibreLibrary&panel=book_details"
   #:location
   (book-chapter-location
    "The Reckoning of Time"
    #:series "by the Venerable Bede, translated by Faith Wallis. Translated Texts for Historians"
    #:volume "29."
    #:publisher "Liverpool, UK: Liverpool University Press")))

(define meeus
  (make-bib
   #:is-book? #t
   #:title "Astronomical Algorithms"
   #:author "Jean Meeus"
   #:date 1998
   ;#:note #f
   #:location (book-location #:edition "2nd"
                             #:publisher "Richmond: Willmann-Bell")))