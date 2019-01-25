FROM golang:1.11 as builder

MAINTAINER Luigi Tagliamonte <luigi@zenreach.com>

RUN curl -s https://glide.sh/get | sh
COPY . /go/src/github.com/percona/mongodb_exporter
RUN cd /go/src/github.com/percona/mongodb_exporter && make build

FROM alpine:3.8
EXPOSE 9216

RUN apk add --update ca-certificates
COPY --from=builder /go/src/github.com/percona/mongodb_exporter/mongodb_exporter /usr/local/bin/mongodb_exporter

ENTRYPOINT [ "mongodb_exporter" ]
