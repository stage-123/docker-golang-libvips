FROM golang:1.14-alpine3.12

RUN apk add --update --no-cache \
--repository http://dl-3.alpinelinux.org/alpine/edge/community \
--repository http://dl-3.alpinelinux.org/alpine/edge/main vips-dev build-base
