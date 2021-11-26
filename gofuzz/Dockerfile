FROM alpine:latest as builder
RUN apk update && \
    apk add go && \
    go get -u github.com/ffuf/ffuf && \
    go install github.com/OJ/gobuster/v3@latest

FROM alpine:latest
COPY --from=builder /root/go/bin/gobuster /usr/local/bin/gobuster
COPY --from=builder /root/go/bin/ffuf /usr/local/bin/ffuf