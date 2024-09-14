;;; Nanopass Compiler Framework ---
;;; Copyright © 2023 Karl Hallsby <karl@hallsby.com>
;;;
;;; This file is part of the Common Lisp implementation of the Nanopass
;;; compilation framework.
;;;
;;; Commentary:
;;
;; GNU Guix development package.  To build and install, run:
;;
;;   guix package -f guix.scm
;;
;; To use as the basis for a development environment, run:
;;
;;   guix shell -D -f guix.scm
;;
;;; Code:

(define-module (nanopass-package)
  #:use-module (guix packages)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix utils)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix build-system asdf)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages texinfo)
  #:use-module (gnu packages lisp)
  #:use-module (gnu packages lisp-xyz)
  #:use-module (gnu packages lisp-check))

(define vcs-file?
  ;; Return true if the given file is under version control.
  (or (git-predicate
       (string-append (current-source-directory) "/../.."))
      (const #t)))

(define-public nanopass
  (package
   (name "nanopass")
   (version "0.0.0")
   (source (local-file "../.." "nanopass-checkout"
                       #:recursive? #t
                       #:select? vcs-file?))
   (native-inputs
    (list sbcl
          cl-lisp-unit2
          cl-log4cl
          autoconf automake
          ;; Building the manual
          texinfo))
   (inputs
    (list cl-alexandria
          cl-slime-swank
          cl-slynk))
   (build-system asdf-build-system/sbcl)
   ;; (build-system asdf-build-system/source) ;; Maybe use this?
   (arguments
    (list
     #:phases
     #~(modify-phases %standard-phases
         (add-after 'check 'install-manual
           (lambda* (#:key (configure-flags '()) (make-flags '()) outputs
                     #:allow-other-keys)
             (let* ((out  (assoc-ref outputs "out"))
                    (info (string-append out "/share/info")))
               (invoke "./bootstrap")
               (apply invoke "sh" "./configure" "SHELL=sh" configure-flags)
               (apply invoke "make" "info" make-flags)
               (install-file "doc/nanopass.info" info)))))))
   (synopsis "Nanopass Compilation framework in ANSI Common Lisp")
   (description "Nanopass Compilation framework in ANSI Common Lisp.")
   (home-page "http://github.com/KarlJoad/nanopass-framework-cl")
   (license license:expat))) ;expat license = MIT license

nanopass
