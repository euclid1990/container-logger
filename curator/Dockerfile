FROM python:3.6-alpine

RUN apk --no-cache add curl

RUN pip install elasticsearch-curator==5.6.0 && \
    rm -rf /var/cache/apk/*

RUN mkdir -p /root/.curator

COPY . /root/.curator/

RUN /usr/bin/crontab /root/.curator/crontab.txt

COPY command.sh /command.sh

CMD ["/bin/sh", "/command.sh"]