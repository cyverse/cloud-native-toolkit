# syntax=docker/dockerfile:1
FROM golang:1.16-alpine

ARG GIT_BRANCH="master"
ARG GIT_COMMIT=""
LABEL org.hydrogen.git.branch="$GIT_BRANCH"
LABEL org.hydrogen.git.commit="$GIT_COMMIT"

ENV GIT_BRANCH="$GIT_BRANCH"
ENV GIT_COMMIT="$GIT_COMMIT"

ARG SKAFFOLD_GO_GCFLAGS
ARG GOTRACEBACK
ENV GOTRACEBACK="$GOTRACEBACK"
COPY ./go.mod ./go.sum ./main.go /hydrogen/

WORKDIR /hydrogen/
RUN --mount=type=cache,target=/root/.cache/go-build eval go build -ldflags \"-X main.GitCommit="${GIT_COMMIT}" -X main.GitBranch="${GIT_BRANCH}"\" -gcflags="${SKAFFOLD_GO_GCFLAGS}"
CMD ["/hydrogen/api"]