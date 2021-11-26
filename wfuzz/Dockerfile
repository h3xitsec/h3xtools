FROM alpine:latest
WORKDIR /app
RUN apk --update add --no-cache python3 git py3-pip && \
    pip install wfuzz && \
    apk del git py3-pip
ENTRYPOINT ["wfuzz"]