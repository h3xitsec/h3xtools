FROM alpine:latest as builder
RUN apk update && \
    apk --no-cache add git && \
    cd /tmp && \
    git clone https://github.com/sullo/nikto

FROM alpine:latest 
COPY --from=builder ["/tmp/nikto/program/", "/nikto"]
ENV  PATH=${PATH}:/nikto
RUN echo 'Installing packages for Nikto.' \
    && apk add --update --no-cache --virtual .build-deps \
        perl \
        perl-net-ssleay \
    && echo 'Creating the nikto group.' \
    && addgroup nikto \
    && echo 'Creating the nikto user.' \
    && adduser -G nikto -g "Nikto user" -s /bin/sh -D nikto \
    && echo 'Changing the ownership.' \
    && chown -R nikto.nikto /nikto \
    && echo 'Finishing image.'
USER nikto
ENTRYPOINT ["nikto.pl"]