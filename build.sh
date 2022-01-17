#!/bin/bash

USER=kishlin

ENV=$1

if [ -z $ENV ] || [ $ENV == "prod" ]; then
	for FILE in $(find prod -name Dockerfile); do
		DOCKER_PATH=$(dirname $FILE);
		DOCKER_NAME=$(head -1 $FILE);
		DOCKER_NAME=${DOCKER_NAME/docker.elastic.co\/elasticsearch\//};
		cd $DOCKER_PATH;
		docker build -t ${USER}/base-${DOCKER_NAME/FROM /kishlin-} .
		cd -
	done
fi

if [ -z $ENV ] || [ $ENV == "dev" ]; then
	for FILE in $(find dev -name Dockerfile); do
		DOCKER_PATH=$(dirname $FILE);
		DOCKER_NAME=$(head -1 $FILE);
		DOCKER_NAME=${DOCKER_NAME/docker.elastic.co\/elasticsearch\//};
		cd $DOCKER_PATH;
		docker build -t ${DOCKER_NAME/FROM /}-dev .
		cd -
	done
fi

if [ -n $ENV ] && [ "$ENV" == "pull" ]; then
	for FILE in $(find prod -name Dockerfile); do
		DOCKER_NAME=$(head -1 $FILE);
		DOCKER_NAME=${DOCKER_NAME/docker.elastic.co\/elasticsearch\//};
		docker pull ${USER}/base-${DOCKER_NAME/FROM /kishlin-}
		docker pull ${USER}/base-${DOCKER_NAME/FROM /kishlin-}-dev
	done
fi

if [ -n $ENV ] && [ "$ENV" == "push" ]; then
	for FILE in $(find prod -name Dockerfile); do
		DOCKER_NAME=$(head -1 $FILE);
		DOCKER_NAME=${DOCKER_NAME/docker.elastic.co\/elasticsearch\//};
		docker push ${USER}/base-${DOCKER_NAME/FROM /kishlin-}
		docker push ${USER}/base-${DOCKER_NAME/FROM /kishlin-}-dev
	done
fi
