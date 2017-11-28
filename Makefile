IMAGE=imega/grpcgen
TAG=latest

build:
	@docker run --rm=false \
		-v $(CURDIR)/build:/build \
		-v $(CURDIR)/runner:/runner \
		imega/base-builder:1.5.0 \
		--packages="musl" \
		--dev-packages="git make autoconf curl libtool automake gcc alpine-sdk unzip go"

test:
	@docker build -t $(IMAGE):$(TAG) .
	docker run -v $(CURDIR)/tests $(IMAGE):$(TAG) protoc -I=. -I=/data/src --gogoslick_out=. test.proto
	docker run -v $(CURDIR)/tests $(IMAGE):$(TAG) protoc -I=. -I=/data/src --gograin_out=. test.proto

release:
	@docker build -t $(IMAGE):$(TAG) .
	@docker login --username $(DOCKER_USER) --password $(DOCKER_PASS)
	@docker push $(IMAGE):$(TAG)


.PHONY: build
