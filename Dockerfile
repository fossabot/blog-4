FROM golang:alpine

# install dependencies
RUN apk add -U git

# install hugo
RUN cd /srv \
    && wget https://github.com/gohugoio/hugo/releases/download/v0.38/hugo_0.38_Linux-64bit.tar.gz \
    && tar xf ./hugo_0.38_Linux-64bit.tar.gz \
    && mv ./hugo /usr/local/bin/hugo \
    && rm -rf /srv/*

WORKDIR /go/src/github.com/codeepblue/blog

COPY ./docker-entrypoint.sh /docker-entrypoint

RUN chmod +x /docker-entrypoint

CMD ["/docker-entrypoint"]
