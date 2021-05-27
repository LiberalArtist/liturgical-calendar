#lang scribble/manual

@title{Liturgical Calendar}
@author[(author+email @elem{Philip M@superscript{c}Grath}
                      "philip@philipmcgrath.com")]
@defmodule[liturgical-calendar]

@(require "bibliography.rkt"
          (for-label liturgical-calendar
                     adjutor/racket/base/minus
                     racket/contract
                     gregor/period
                     gregor))

The @racketmodname[liturgical-calendar] library provides functions
to compute the dates of Easter and other Christian holidays.
It uses the representation of @seclink[#:doc gregor-doc "date"]{dates}
from @other-doc[gregor-doc].
Currently, @racketmodname[liturgical-calendar] supports the calendar
used primarily by churches originating in the Western half of the
Roman empire: see the @seclink["Introduction"]{introduction} for details.

@(local-table-of-contents)

@section{Introduction}

Coming soon ...

@other-doc[gregor-doc]

@citet[bcp]

@citet[meeus]

@citet[bien]

@citet[wallis]

@section{Reference}

@defproc[(year->advent-start [year exact-positive-integer?])
         (and/c date? sunday?)]
@defproc[(year->christmas [year exact-positive-integer?])
         date?]
@defproc[(year->epiphany [year exact-positive-integer?])
         date?]
@defproc[(year->candlemas [year exact-positive-integer?])
         date?]
@defproc[(year->ash-wednesday [year exact-positive-integer?])
         (and/c date? wednesday?)]
@defproc[(year->easter [year exact-positive-integer?])
         (and/c date? sunday?)]
@defproc[(year->ascension-thursday [year exact-positive-integer?])
         (and/c date? thursday?)]
@defproc[(year->pentecost [year exact-positive-integer?])
         (and/c date? sunday?)]
@defproc[(year->trinity-sunday [year exact-positive-integer?])
         (and/c date? sunday?)]

@;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
@;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
@(generate-bibliography)
