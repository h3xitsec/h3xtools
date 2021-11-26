FROM alpine:latest
WORKDIR /app
RUN apk update && \
    apk add python3 git && \
    git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git sqlmap && \
    chmod +x /app/sqlmap/sqlmap.py && \
    apk del git
ENTRYPOINT ["/usr/bin/python3"]
CMD ["/app/sqlmap/sqlmap.py"]