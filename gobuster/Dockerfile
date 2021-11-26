FROM alpine:latest as builder
RUN apk update && \
    apk add go && \
    go install github.com/OJ/gobuster/v3@latest

FROM alpine:latest
COPY --from=builder /root/go/bin/gobuster /usr/local/bin/gobuster
ENTRYPOINT ["/usr/local/bin/gobuster"]