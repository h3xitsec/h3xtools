FROM ubuntu:latest as builder
WORKDIR /app
RUN apt-get -y update && \
    apt-get -y install \
    curl \
    gnupg2 \
    ruby
RUN curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && \
    chmod 755 msfinstall && \
    ./msfinstall

FROM ubuntu:latest
#RUN apk update && \
#    apk --no-cache add ruby
COPY --from=builder /opt/metasploit-framework/ /opt/metasploit-framework/