FROM python:3.8-alpine

ARG CURATOR_VERSION
ARG CURATOR_SCHEDULE="0 0 * * *"

RUN apk --no-cache add curl

RUN pip install elasticsearch-curator==${CURATOR_VERSION} && \
    rm -rf /var/cache/apk/*

RUN mkdir -p /root/.curator

COPY . /root/.curator/

RUN echo "${CURATOR_SCHEDULE} curator /root/.curator/action.yml > /dev/stdout" > /root/.curator/crontab.conf

RUN /usr/bin/crontab /root/.curator/crontab.conf

COPY command.sh /command.sh

CMD ["/bin/sh", "/command.sh"]
