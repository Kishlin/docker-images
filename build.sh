#!/bin/bash
set -euo pipefail

# Usage: ./build.sh [prod|dev|pull|push] [target]
#   target restricts the run to one tech (e.g. "golang") or one
#   tech/version (e.g. "golang/1.26"). Omit it to run against everything.

USER=kishlin

ENV=${1:-}
TARGET=${2:-}

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

# Fails the whole script if $1 doesn't exist. Must be called directly
# (never inside $(...) or <(...)), otherwise exit only kills a subshell.
require_dir() {
	if [ ! -d "$1" ]; then
		echo "No such directory: $1" >&2
		exit 1
	fi
}

if [ -z "$ENV" ] || [ "$ENV" == "prod" ]; then
	DIR="prod${TARGET:+/$TARGET}"
	require_dir "$DIR"
	mapfile -t FILES < <(find "$DIR" -name Dockerfile)
	for FILE in "${FILES[@]}"; do
		docker build -t "$(prod_tag_for "$FILE")" "$(dirname "$FILE")"
	done
fi

if [ -z "$ENV" ] || [ "$ENV" == "dev" ]; then
	DIR="dev${TARGET:+/$TARGET}"
	require_dir "$DIR"
	mapfile -t FILES < <(find "$DIR" -name Dockerfile)
	for FILE in "${FILES[@]}"; do
		docker build -t "$(dev_tag_for "$FILE")" "$(dirname "$FILE")"
	done
fi

if [ -n "$ENV" ] && [ "$ENV" == "pull" ]; then
	DIR="prod${TARGET:+/$TARGET}"
	require_dir "$DIR"
	mapfile -t FILES < <(find "$DIR" -name Dockerfile)
	for FILE in "${FILES[@]}"; do
		TAG=$(prod_tag_for "$FILE")
		docker pull "$TAG"
		docker pull "${TAG}-dev"
	done
fi

if [ -n "$ENV" ] && [ "$ENV" == "push" ]; then
	DIR="prod${TARGET:+/$TARGET}"
	require_dir "$DIR"
	mapfile -t FILES < <(find "$DIR" -name Dockerfile)
	for FILE in "${FILES[@]}"; do
		TAG=$(prod_tag_for "$FILE")
		docker push "$TAG"
		docker push "${TAG}-dev"
	done
fi
