#!/bin/bash

set -euo pipefail

until curl -s "${KIBANA_URL}/login" | grep "Loading Kibana" > /dev/null; do
	  echo "Waiting for kibana..."
	  sleep 1
done

metricbeat --strict.perms=false -system.hostfs=/hostfs
