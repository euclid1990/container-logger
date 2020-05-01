ARG ELKF_VERSION

FROM docker.elastic.co/logstash/logstash:${ELKF_VERSION}

COPY logstash.yml /usr/share/logstash/config/logstash.yml

COPY logstash.conf /usr/share/logstash/pipeline/logstash.conf
