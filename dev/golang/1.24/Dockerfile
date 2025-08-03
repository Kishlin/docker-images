FROM kishlin/base-kishlin-golang:1.24

# Switch back to root for installing packages and setting up permissions
USER root

ENV GO111MODULE=on
ENV CGO_ENABLED=0
ENV GOOS=linux

USER gouser

RUN curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/HEAD/install.sh | sh -s -- -b $(go env GOPATH)/bin v2.3.1

RUN go install github.com/go-delve/delve/cmd/dlv@latest && \
    go install golang.org/x/tools/gopls@latest && \
    go install github.com/ramya-rao-a/go-outline@latest && \
    go install github.com/uudashr/gopkgs/v2/cmd/gopkgs@latest && \
    go install github.com/cweill/gotests/gotests@latest

RUN go install github.com/air-verse/air@latest

CMD ["go", "version"]
