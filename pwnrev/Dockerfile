FROM alpine:edge
RUN apk update && \
    apk add --no-cache \ 
    python3 \
    python3-dev \
    py3-pip \
    gcc \
    git \
    musl-dev && \
    addgroup -g 1000 h3x && \
    adduser h3x -u 1000 -G h3x -g h3x -S && \
    pip install \
    wheel \
    distorm3 && \
    git clone https://github.com/volatilityfoundation/volatility3/ /opt/volatility3 && \
    rm -rf /opt/volatility3/.git && \
    chown -R h3x:h3x /opt/volatility3 && \
    apk del git \
    gcc
USER h3x