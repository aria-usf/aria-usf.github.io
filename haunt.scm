(use-modules (haunt asset)
             (haunt builder blog)
             (haunt builder atom)
             (haunt builder rss)
             (haunt builder assets)
             (haunt reader commonmark)
             (haunt site))

(site #:title "ARIA"
      #:domain "aria-usf.github.io"
      #:default-metadata
      '((author . "Yiyu Zhou")
        (email  . "yzhou155@dons.usfca.edu"))
      #:readers (list commonmark-reader)
      #:builders (list (blog)
                       (atom-feed)
                       (atom-feeds-by-tag)
                       (static-directory "images")))
