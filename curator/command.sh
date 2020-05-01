#!/bin/sh

while [[ "$(curl -u "${ELASTIC_HTTP_AUTH}" -s -o /dev/null -w '%{http_code}' $ELASTIC_URL)" != "200" ]]; do
    echo "[Curator] Waiting for Elasticsearch..."
    sleep ${RETRY_TIME}
done

echo "[Curator] Conneted to Elasticsearch!"

/usr/sbin/crond -f
