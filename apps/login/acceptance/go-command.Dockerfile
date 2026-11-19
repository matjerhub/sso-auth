# syntax=docker/dockerfile:1
ARG LOGIN_TEST_ACCEPTANCE_GOLANG_TAG="golang:1.24-alpine"

FROM ${LOGIN_TEST_ACCEPTANCE_GOLANG_TAG}
RUN apk add curl jq
COPY go.mod go.sum ./
RUN --mount=type=cache,target=/go/pkg/mod \
    go mod download
COPY . .
ARG APP_PATH=.
RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=cache,target=/root/.cache/go-build \
    CGO_ENABLED=0 GOOS=linux go build -trimpath -ldflags="-s -w" -o /go-command ${APP_PATH}
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s \
  CMD curl -f http://localhost:${PORT}/healthy || exit 1
ENTRYPOINT [ "/go-command" ]
