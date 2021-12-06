FROM rubylang/ruby:master-nightly-bionic
ARG HT_USER=h3x
RUN deluser ubuntu \
    && addgroup --gid 1000 $HT_USER                                                               \
    && adduser h3x -u 1000 --gid 1000 --disabled-password                                   \
    && gem install ctf-party
USER $HT_USER
CMD ["/bin/bash"]