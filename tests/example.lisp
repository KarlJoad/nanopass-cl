(defpackage :nanopass/tests
  (:use :cl :lisp-unit2))

(in-package :nanopass/tests)

(define-test example ()
  (assert-eql 1 (- 2 1)))
