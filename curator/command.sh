#!/bin/sh

while [[ "$(curl -u "${ELASTIC_HTTP_AUTH}" -s -o /dev/null -w '%{http_code}' $ELASTIC_URL)" != "200" ]]; do
    echo "Waiting for Elasticsearch..."
    sleep 3
done

/usr/sbin/crond -f