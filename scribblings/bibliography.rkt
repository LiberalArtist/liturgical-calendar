#lang at-exp racket

(require scriblib/autobib)

(provide ~cite
         citet
         generate-bibliography
         in-bib
         bcp
         bien
         wallis
         meeus)

(define author+date-style%
  (class object%
    (define-syntax-rule (methods (name arg ...) ...)
      (begin (define/public (name arg ...)
               (send author+date-style name arg ...))
             ...))
    (methods 
     (bibliography-table-style)
     (entry-style)
     (disambiguate-date?)
     (collapse-for-date?)
     (get-cite-open)
     (get-cite-close)
     (get-group-sep)
     (get-item-sep)
     (render-citation date-cite i)
     (render-author+dates author dates)
     (bibliography-line i e))
    (super-new)))

(require racket/gui)
(define debug-out
  (let ([f (new frame% [label "output"])]
      [ed (new text%)])
  (new editor-canvas%
       [parent f]
       [editor ed])
  (send f show #t)
  (open-output-text-editor ed)))


(define author+date-custom-style-hack
  (new (class author+date-style%
         (define/override (render-author+dates author dates)
           (pretty-print (list author dates) debug-out)
           (error)
           (super render-author+dates author dates))
         (super-new))))
         


(define-cite ~cite citet generate-bibliography
  #:style author+date-custom-style-hack)


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


(define bcp
  (make-bib
   #:is-book? #t
   #:title "The Book of Common Prayer"
   #:author (org-author-name "The Episcopal Church")
   #:date 2007
   ;#:note
   #:url "https://bcponline.org" ;"https://perma.cc/BCC2-C9CY"
   #:location
   (book-location
    #:edition 1979
    #:publisher "New York: Church Publishing")))