build:
	@docker run --rm=false \
		-v $(CURDIR)/build:/build \
		-v $(CURDIR)/runner:/runner \
		imega/base-builder:1.5.0 \
		--packages="musl" \
		--dev-packages="git make autoconf curl libtool automake gcc alpine-sdk unzip"

.PHONY: build
