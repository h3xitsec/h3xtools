FROM alpine:edge
RUN apk update && \
    apk --no-cache add \
    nmap \
    nmap-scripts
ENTRYPOINT ["/usr/bin/nmap"]