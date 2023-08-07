(defpackage nanopass
  (:use :cl)
  (:export #:hello))

(in-package :nanopass)

(defun hello ()
  (format t "Hello to your Nanopass Compiler!~&"))
