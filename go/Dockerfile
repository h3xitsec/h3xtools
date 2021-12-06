FROM h3xtools/h3xbuilder:alpine as builder
USER root
RUN apk add --update --no-cache \
    && go get -u github.com/ffuf/ffuf \
    && go install github.com/OJ/gobuster/v3@latest

FROM h3xtools/h3xbase:alpine
ARG HT_USER=h3x
COPY --from=builder /root/go/bin/gobuster /usr/local/bin/gobuster
COPY --from=builder /root/go/bin/ffuf /usr/local/bin/ffuf
USER $HT_USER