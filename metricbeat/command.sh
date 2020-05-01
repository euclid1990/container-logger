#!/bin/bash

set -euo pipefail

until curl -s "${KIBANA_URL}/login" | grep "Loading Kibana" > /dev/null; do
	  echo "[Metricbeat] Waiting for Kibana..."
	  sleep ${RETRY_TIME}
done

echo "[Metricbeat] Conneted to Kibana!"

metricbeat -e --strict.perms=false -system.hostfs=/hostfs
