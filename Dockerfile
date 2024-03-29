FROM golang:1.14 AS builder

WORKDIR /go/src/github.com/rainy/prometheus-nacos-sd
COPY ./ ./
RUN go mod vendor && \
    GOARCH=amd64 GOOS=linux CGO_ENABLED=0 go build -ldflags "-w -s" -o /prometheus-nacos-sd main.go

FROM alpine:edge
RUN apk add --update --no-cache ca-certificates
COPY --from=builder /prometheus-nacos-sd /prometheus-nacos-sd
ENTRYPOINT ["/prometheus-nacos-sd"]