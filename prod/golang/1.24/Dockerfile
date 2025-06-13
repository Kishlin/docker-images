FROM golang:1.24

WORKDIR /app

ENV GO111MODULE=on
ENV CGO_ENABLED=0
ENV GOOS=linux

RUN apt-get update && apt-get install -y \
    git \
    curl \
    make \
    gcc \
    vim \
    jq \
    zip \
    unzip \
    && rm -rf /var/lib/apt/lists/*

RUN go install golang.org/x/lint/golint@latest

ENV PATH="/go/bin:${PATH}"

RUN useradd -m gouser

RUN mkdir -p /go/pkg/mod/cache/download && \
    mkdir -p /go/bin && \
    chown -R gouser:gouser /go

USER gouser

CMD ["go", "version"]
