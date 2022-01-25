FROM golang:1.14 AS builder

WORKDIR /go/src/github.com/rainy/prometheus-nacos-sd
COPY ./ ./

RUN  go build -ldflags "-w -s" -o /prometheus-nacos-sd main.go

FROM alpine:edge
RUN apk add --update --no-cache ca-certificates
COPY --from=builder /prometheus-nacos-sd /prometheus-nacos-sd
USER nobody
ENTRYPOINT ["/prometheus-nacos-sd"]