(defsystem :nanopass
  :author "Karl Hallsby <karl@hallsby.com>"
  :description "Nanopass Compilation Framework in Common Lisp"
  :pathname #p"source/"
  :components ((:file "nanopass"))
  :depends-on (:uiop :alexandria)
  :in-order-to ((test-op (test-op "nanopass/tests"))))

(defsystem :nanopass/tests
  :depends-on (:nanopass :alexandria :lisp-unit2)
  :pathname #p"tests/"
  :components ((:file "example")))
