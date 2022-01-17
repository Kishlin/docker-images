push:
	./build.sh push

pull:
	./build.sh pull

build:
	./build.sh

build-dev:
	./build.sh dev

build-prod:
	./build.sh prod

.PHONY: build-dev build-prod
