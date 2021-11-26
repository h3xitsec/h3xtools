FROM alpine:latest
WORKDIR /app
RUN apk update && \
    apk add --no-cache make g++ libssh-dev openssl-dev
ADD https://github.com/vanhauser-thc/thc-hydra/archive/refs/tags/v9.2.tar.gz hydra.tar.gz
RUN tar xvzf hydra.tar.gz && \
    cd thc-hydra-9.2 && \
    ./configure && \
    make && \
    make install && \
    apk del make g++
ENTRYPOINT ["/usr/local/bin/hydra"]