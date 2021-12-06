FROM python:3.7.12-alpine3.15
ARG HT_USER=root
WORKDIR /app
RUN addgroup -g 1000 $HT_USER                                                           && \
    adduser h3x -u 1000 -G $HT_USER -g $HT_USER -S                                      && \
    echo 'https://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories  && \
    apk --update --no-cache add                                                         \
    git                                                                                 \
    build-base                                                                          && \
    git clone https://github.com/ticarpi/jwt_tool /opt/jwt_tool                         && \
    chown $HT_USER:$HT_USER -R /opt/jwt_tool                                            && \
    pip install                                                                         \
    termcolor                                                                           \
    cprint                                                                              \
    pycryptodomex                                                                       \ 
    requests                                                                            && \
    apk del git build-base
USER $HT_USER