.PHONY: build run sh

VENDOR=codeepblue
PROJECT=$(VENDOR)/blog

default: build

docker:
	docker build -t $(PROJECT) .

build: docker

run:
	docker run -it --rm -v $(PWD):/go/src/github.com/$(PROJECT) $(PROJECT)

sh:
	docker run -it --rm -v $(PWD):/go/src/github.com/$(PROJECT) $(PROJECT) sh
