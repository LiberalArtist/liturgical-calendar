#lang at-exp racket

(require scriblib/autobib
         scribble/manual)

(provide ~cite
         citet
         generate-bibliography
         in-bib
         gregor-doc
         bcp
         bien
         wallis
         meeus)



(define-cite ~cite citet generate-bibliography)

(define gregor-doc
  '(lib "gregor/scribblings/gregor.scrbl"))
;(in-bib orig where)

;; TODO:
;;   - https://doi.org/10.1484/J.VIATOR.2.300394
;;   - https://www.jstor.org/stable/42974022
;;   - https://en.wikipedia.org/wiki/Calendar_(New_Style)_Act_1750
;;   - https://en.wikipedia.org/wiki/Christopher_Clavius
;;   - https://en.wikipedia.org/wiki/Aloysius_Lilius
;;   - DMLBS s.v. "computus"
;;   - https://web.archive.org/web/20150907215917/http://www.merlyn.demon.co.uk/estr-bcp.htm
;;   - https://www.assa.org.au/edm

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
   #:author (org-author-name "Episcopal Church")
   #:date 2007
   #:location
   (book-location
    #:edition 1979
    #:publisher "New York: Church Publishing")
   #:url "https://perma.cc/BCC2-C9CY"
   #:note @elem[" "]{(PDF).
 Web version at @url["https://bcponline.org"].
 See in particular “The Calendar of the Church Year,” pp. 15--33
 (@link["https://bcponline.org/General/calendar.html"]{web}),
 and “Tables and Rules for Finding
 the Date of Easter Day,” pp. 880--885
 (@link["https://bcponline.org/Misc/tables.html"]{web}).
 }))