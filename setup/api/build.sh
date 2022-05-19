export DOCKER_BUILDKIT=1

export DOCKER_IMAGE_PREFIX="stack0verflow/"
# export DOCKER_IMAGE_PREFIX=""

export DOCKER_IMAGE_NAME=ccnt-api
export DOCKER_IMAGE_TAG=latest

GIT_BRANCH=`git rev-parse --abbrev-ref HEAD`
GIT_COMMIT=`git rev-parse --short HEAD`

docker build --build-arg GIT_BRANCH=${GIT_BRANCH} --build-arg GIT_COMMIT=${GIT_COMMIT} -t ${DOCKER_IMAGE_PREFIX}${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} .
docker push ${DOCKER_IMAGE_PREFIX}${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}
