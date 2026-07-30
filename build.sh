#!/bin/bash
set -euo pipefail

USER=kishlin

ENV=${1:-}

# Tag for a prod image, derived from its directory (tech) and its FROM line's
# version suffix (the part after the last ':'), e.g. prod/node/20.18.1 with
# "FROM node:20.18.1-alpine" -> kishlin/base-kishlin-node:20.18.1-alpine
prod_tag_for() {
	local FILE=$1
	local TECH
	TECH=$(basename "$(dirname "$(dirname "$FILE")")")
	local FROM_LINE
	FROM_LINE=$(grep -m1 -E '^FROM' "$FILE")
	local VERSION=${FROM_LINE##*:}
	echo "${USER}/base-${USER}-${TECH}:${VERSION}"
}

# Tag for a dev image: dev Dockerfiles are FROM the prod image itself, so we
# just take that FROM target and append -dev.
dev_tag_for() {
	local FILE=$1
	local FROM_LINE
	FROM_LINE=$(grep -m1 -E '^FROM' "$FILE")
	echo "${FROM_LINE#FROM }-dev"
}

if [ -z "$ENV" ] || [ "$ENV" == "prod" ]; then
	for FILE in $(find prod -name Dockerfile); do
		docker build -t "$(prod_tag_for "$FILE")" "$(dirname "$FILE")"
	done
fi

if [ -z "$ENV" ] || [ "$ENV" == "dev" ]; then
	for FILE in $(find dev -name Dockerfile); do
		docker build -t "$(dev_tag_for "$FILE")" "$(dirname "$FILE")"
	done
fi

if [ -n "$ENV" ] && [ "$ENV" == "pull" ]; then
	for FILE in $(find prod -name Dockerfile); do
		TAG=$(prod_tag_for "$FILE")
		docker pull "$TAG"
		docker pull "${TAG}-dev"
	done
fi

if [ -n "$ENV" ] && [ "$ENV" == "push" ]; then
	for FILE in $(find prod -name Dockerfile); do
		TAG=$(prod_tag_for "$FILE")
		docker push "$TAG"
		docker push "${TAG}-dev"
	done
fi
