FROM python:3.7.12-alpine3.15
ARG HT_USER=root
WORKDIR /app
RUN addgroup -g 1000 $HT_USER                                                               \
    && adduser h3x -u 1000 -G $HT_USER -g $HT_USER -S                                       \
    && echo 'https://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories   \
    && apk --update --no-cache add                                                          \
    git                                                                                     \
    cmake                                                                                   \
    build-base                                                                              \
    gmp-dev                                                                                 \
    mpfr-dev                                                                                \
    mpc1-dev                                                                                \
    openssl-dev                                                                             \
    libffi-dev                                                                              \
    && git clone https://github.com/Ganapati/RsaCtfTool.git /opt/rsactftool                 \
    && pip install -r "/opt/rsactftool/requirements.txt"                                    \
    && git clone https://github.com/zweisamkeit/RSHack /opt/rshack                          \
    && pip install -r "/opt/rshack/requirements.txt"                                        \
    && chown -R $HT_USER:$HT_USER /opt/*                                                    \
    && apk del build-base git cmake
USER $HT_USER