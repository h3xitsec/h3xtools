FROM python:3.7.12-alpine3.15 as builder
WORKDIR /app
RUN echo 'https://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && \
    apk --update --no-cache add \
    wget \
    git \
    python3 \
    python3-dev \
    musl-dev \
    py3-pip \
    build-base \
    curl-dev && \
    wget https://raw.githubusercontent.com/21y4d/nmapAutomator/master/nmapAutomator.sh && \
    chmod +x /app/nmapAutomator.sh && \
    git clone https://github.com/sullo/nikto /tmp/nikto && \
    git clone https://github.com/xmendez/wfuzz/ /tmp/wfuzz
WORKDIR /tmp/wfuzz
RUN pip install setuptools && \
    python3 setup.py install

FROM python:3.7.12-alpine3.15
WORKDIR /app
RUN echo 'https://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && \
    apk --update --no-cache add \
    nmap \
    nmap-scripts \
    bind-tools \
    sslscan \
    dnsrecon \
    perl \
    perl-net-ssleay \
    python3 \
    curl-dev && \
    ln -s /app/nikto/nikto.pl /usr/local/bin/nikto
COPY --from=builder /usr/local/ /usr/local
COPY --from=builder /tmp/nikto/program/ /app/nikto
COPY --from=builder /app/nmapAutomator.sh /usr/local/bin/nmapAutomator
WORKDIR /root