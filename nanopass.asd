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

(defmethod asdf:perform ((o asdf:test-op) (c (eql (find-system :nanopass/tests))))
  ;; Binding `*package*' to package-under-test makes for more reproducible tests.
  (let ((*package* (find-package :nanopass/tests)))
    (uiop:symbol-call
     :lisp-unit2 :run-tests
     :package *package*
     :name :nanopass
     :run-contexts (find-symbol "WITH-SUMMARY-CONTEXT" :lisp-unit2))))
