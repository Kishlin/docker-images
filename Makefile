TARGET ?=

push:
	./build.sh push $(TARGET)

pull:
	./build.sh pull $(TARGET)

build:
	./build.sh "" $(TARGET)

build-dev: build-prod
	./build.sh dev $(TARGET)

build-prod:
	./build.sh prod $(TARGET)

.PHONY: push pull build build-dev build-prod
