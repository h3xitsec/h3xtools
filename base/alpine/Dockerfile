FROM alpine:edge
ARG HT_USER=h3x
RUN addgroup -g 1000 $HT_USER                                                               \
    && adduser h3x -u 1000 -G $HT_USER -g $HT_USER -S
USER $HT_USER