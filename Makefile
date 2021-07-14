GOOS_GOARCH := $(word 4, $(shell go version))
GOOS        ?= $(word 1, $(subst /, , $(GOOS_GOARCH)))
GOARCH      ?= $(word 2, $(subst /, , $(GOOS_GOARCH)))

GIT_TAG ?= $(shell git describe --tags --always)
GIT_SHA ?= $(shell git rev-parse --short HEAD)

VERSION  := $(shell echo $(GIT_TAG) | awk -F'[-v]' '{print $$2}')
REVISION := $(shell echo $(GIT_SHA) | head -c 8)

BUILD_FLAGS := -ldflags "-s -w -X main.Version=$(VERSION) -X main.Revision=$(REVISION)"

ARCHIVE := mkcert-$(VERSION)-$(GOOS)_$(GOARCH).tar.xz

mkcert:
	CGO_ENABLED=0 go build $(BUILD_FLAGS) -o $@

release: mkcert
	tar -Jcvf $(ARCHIVE) $^
	$(RM) -- $^
