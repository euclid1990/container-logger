ARG ELKF_VERSION

FROM docker.elastic.co/beats/filebeat:${ELKF_VERSION}

COPY filebeat.yml /usr/share/filebeat/filebeat.yml

USER root

COPY command.sh /command.sh
