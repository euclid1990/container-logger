#!/bin/bash

set -euo pipefail

until curl -s "${KIBANA_URL}/login" | grep "Loading Kibana" > /dev/null; do
    echo "[Filebeat] Waiting for Kibana..."
    sleep ${RETRY_TIME}
done

echo "[Filebeat] Conneted to Kibana!"

# By default Filebeat/Metricbeat not automatically load the index template if we not use Elasticsearch directly
filebeat setup --index-management -E output.logstash.enabled=false \
    -E 'output.elasticsearch.hosts=["${ELASTIC_HOST}:${ELASTIC_PORT}"]' \
    -E 'output.elasticsearch.username="${ELASTIC_USERNAME}"' \
    -E 'output.elasticsearch.password="${ELASTIC_PASSWORD}"'

filebeat -e -strict.perms=false
