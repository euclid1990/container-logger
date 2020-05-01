ARG ELKF_VERSION

FROM docker.elastic.co/beats/metricbeat:${ELKF_VERSION}

COPY metricbeat.yml /usr/share/metricbeat/metricbeat.yml

COPY command.sh /command.sh
