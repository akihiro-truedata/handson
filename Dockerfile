# Build Server
FROM golang:latest as builder
ENV GOBIN /go/bin
WORKDIR /go/src/github.com/akihiro-truedata/handson
COPY / .
# WORKDIR配下のmain.goがsample-akiyama-serverでbuildされる
RUN GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o sample-akiyama-server

# COPY theserver file to image from builder
FROM alpine:latest
WORKDIR /usr/local/bin/

# ビルドしたbinaryをbuilderイメージから取得
COPY --from=builder /go/src/github.com/akihiro-truedata/handson/sample-akiyama-server .

EXPOSE 8080

CMD ["/usr/local/bin/sample-akiyama-server"]
