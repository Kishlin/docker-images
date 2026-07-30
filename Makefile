push:
	./build.sh push

pull:
	./build.sh pull

build:
	./build.sh

build-dev: build-prod
	./build.sh dev

build-prod:
	./build.sh prod

.PHONY: push pull build build-dev build-prod
