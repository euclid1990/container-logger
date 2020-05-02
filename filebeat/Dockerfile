ARG ELKF_VERSION

FROM docker.elastic.co/beats/filebeat:${ELKF_VERSION}

COPY filebeat.yml /usr/share/filebeat/filebeat.yml

RUN chmod go-w /usr/share/filebeat/filebeat.yml

COPY command.sh /command.sh
