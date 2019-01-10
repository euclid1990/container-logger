FROM fluent/fluentd:v0.12.43-onbuild

RUN apk update \
 && apk upgrade \
 && apk add --no-cache --virtual .build-deps \
    build-base \
    ruby-dev \
 && gem install fluent-plugin-elasticsearch -v 3.0.1 \
 && gem sources --clear-all \
 && apk del .build-deps \
 && rm -rf /var/cache/apk/* \
 && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

COPY fluent.conf /fluentd/etc/
