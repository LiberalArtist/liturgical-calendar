#lang scribble/manual

@title{Liturgical Calendar}
@author[(author+email @elem{Philip M@superscript{c}Grath}
                      "philip@philipmcgrath.com")]
@defmodule[liturgical-calendar]

@(require "bibliography.rkt"
          (for-label liturgical-calendar
                     adjutor/racket/base/minus
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

@other-doc[gregor-doc]

@citet[bcp]

@citet[meeus]

@citet[bien]

@citet[wallis]

@section{Reference}


@(generate-bibliography)
