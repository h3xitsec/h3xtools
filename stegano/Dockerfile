FROM alpine:edge as builder
WORKDIR /app
RUN echo 'https://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && \
    apk --update add --no-cache --virtual .buildtools \
    g++ \
    cmake \
    make \
    libmcrypt-dev \
    libmhash-dev \
    libjpeg-turbo-dev \
    zlib-dev \
    git && \
    git clone https://github.com/RickdeJager/stegseek.git && \
    cd stegseek && \
    mkdir -p build && \
    cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release .. && \
    make && \
    make install && \
    apk del .buildtools

FROM alpine:edge
WORKDIR /app
COPY --from=builder /usr/local/bin/stegseek /usr/local/bin/stegseek
RUN echo 'https://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && \
    apk --update add --no-cache \
    steghide \
    binwalk \
