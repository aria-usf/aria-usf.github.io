(use-modules (haunt asset)
             (haunt builder blog)
             (haunt builder flat-pages)
             (haunt builder atom)
             (haunt builder rss)
             (haunt builder assets)
             (haunt reader commonmark)
             (haunt site))

(define footer
  `(footer (@ (class "text-center"))
           (p "Copyright (C) 2026 ARIA")
	   (p "This work is marked under "
	      (a (@ (href "https://creativecommons.org/publicdomain/zero/1.0"))
		 "CC0 1.0 Universal")
	      ".  The "
	      (a (@ (href "https://github.com/aria-usf/aria-usf.github.io"))
		 "source code")
	      " of this site is licensed under the "
	      (a (@ (href "https://www.gnu.org/licenses/gpl-3.0.html"))
		 "GNU General Public License v3.0 or later")
	      ".  This site is built using "
	      (a (@ (href "https://dthompson.us/projects/haunt.html"))
		 "Haunt")
	      " with "
	      (a (@ (href "https://www.gnu.org/software/guile"))
		 "Guile Scheme")
	      ".")
           (p "ARIA is an "
	      (a (@ (href "https://myusf.usfca.edu/sle/student-orgs/undergraduate"))
		 "Undergraduate Student Organization")
	      " approved by but not affiliated with the University of
San Francisco.")
           (p "University of San Francisco and its logo are registered
trademarks of the regents of the University of San Francisco in the
U.S. and other countries.  All other product names, logos, and brands
are property of their respective owners.")))

(define (stylesheet name)
  `(link (@ (rel "stylesheet")
            (href ,(string-append "/css/" name ".css")))))

(define (link text uri)
  `(a (@ (href ,uri)) ,text))

(define yiyu-theme
  (theme #:name "ARIA"
	 #:layout
	 (lambda (site title body)
           `((doctype "html")
             (head
              (meta (@ (charset "utf-8")))
              (meta (@ (name "viewport")
                       (content "width=device-width, initial-scale=1")))
              (title ,(string-append title " — " (site-title site)))
              (link (@ (rel "alternate")
                       (type "application/atom+xml")
                       (title "Atom feed")
                       (href "/feed.xml")))
	      ,(stylesheet "reset")
	      ,(stylesheet "fonts")
	      ,(stylesheet "dthompson"))
	     (body
              (nav
               (ul (li ,(link "ARIA" "/")))
               (ul (li ,(link "About" "/about.html"))
                   (li ,(link "Blog" "/index.html"))
                   (li ,(link "Contact" "/contact.html"))))
	      ,body
	      ,footer)))))

(site #:title "ARIA"
      #:domain "aria-usf.github.io"
      #:default-metadata
      '((author . "Yiyu Zhou")
        (email  . "yzhou155@dons.usfca.edu"))
      #:readers (list commonmark-reader)
      #:builders (list (blog #:theme yiyu-theme)
                       (flat-pages "pages"
                                   #:template (theme-layout yiyu-theme))
                       (atom-feed)
                       (atom-feeds-by-tag)
                       (static-directory "css")
                       (static-directory "images")))
