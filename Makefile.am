LISP_PROG := @LISP_PROGRAM@
LISP_FLAGS := --no-userinit --non-interactive

makefile_dir := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

lisp_eval := $(LISP_PROG) $(LISP_FLAGS) \
             --eval '(require "asdf")' \
             --eval '(asdf:load-asd "$(makefile_dir)/nanopass.asd")' \
             --eval

lisp_quit := --eval '(uiop:quit)'

nanopass_files := nanopass.asd $(shell find . -type f -name '*.lisp')

.PHONY: build
build: $(nanopass_files)
	$(lisp_eval) '(asdf:compile-system :nanopass)'

nanopass_tests := nanopass.asd $(shell find ./tests/ -type f -name '*.lisp')
.PHONY: check
check: $(nanopass_files) $(nanopass_tests)
	$(lisp_eval) '(asdf:test-system :nanopass)'

include doc/local.mk
