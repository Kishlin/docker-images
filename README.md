# docker-images

Personal collection of base Docker images, pushed to Docker Hub under `kishlin/`.

## Layout

```
prod/<tech>/<version>/Dockerfile   # base image (runtime only)
dev/<tech>/<version>/Dockerfile    # builds FROM the prod image, adds dev tooling
```

Dev images extend the corresponding prod image with development tools
(xdebug + composer for PHP, delve/gopls/golangci-lint/air for Go, etc.),
so prod images stay lean.

Some old versions (MySQL 5.6, Node 8, PHP 7.4, Postgres 9.4, ...) are kept
on purpose to support legacy projects.

## Usage

```sh
make build        # build everything (prod first, then dev)
make build-prod   # prod images only
make build-dev    # dev images only (requires prod images locally)
make push         # push all images to Docker Hub
make pull         # pull all images from Docker Hub
```

Tags follow the pattern `kishlin/base-kishlin-<tech>:<version>` for prod,
with a `-dev` suffix for dev images.
