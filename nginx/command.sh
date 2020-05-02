#!/bin/bash

set -euo pipefail

until curl -s "${KIBANA_URL}/login" | grep "Loading Kibana" > /dev/null; do
    echo "[Nginx] Waiting for Kibana..."
    sleep ${RETRY_TIME}
done

echo "[Nginx] Conneted to Kibana!"

# We must make a “service account” for Nginx proxy and a role that allows it to impersonate our users: elastic
createdRole=$(curl -s --user "${ELASTIC_HTTP_AUTH}" -XPOST -H 'Content-Type: application/json' "${ELASTIC_URL}/_xpack/security/role/${NGINX_SERVICE_ACCOUNT_ROLE}" -d \
"$(cat <<EOF
{
  "run_as": ["${ELASTIC_USERNAME}"]
}
EOF
)" | jq ".role.created")

if [ "$createdRole" == "true" ]; then
    echo "[Nginx] Created $NGINX_SERVICE_ACCOUNT_ROLE role!"
fi

createdUser=$(curl -s --user "${ELASTIC_HTTP_AUTH}" -XPOST -H 'Content-Type: application/json' "${ELASTIC_URL}/_xpack/security/user/${NGINX_SERVICE_ACCOUNT_USERNAME}" -d \
"$(cat <<EOF
{
  "password": "${NGINX_SERVICE_ACCOUNT_PASSWORD}",
  "roles": [
    "${NGINX_SERVICE_ACCOUNT_ROLE}"
  ],
  "full_name": "Service Account"
}
EOF
)" | jq ".created")

if [ "$createdUser" == "true" ]; then
    echo "[Nginx] Created $NGINX_SERVICE_ACCOUNT_USERNAME username!"
fi

# Generate config file from variable references in the Nginx config template
export NGINX_SERVICE_ACCOUNT_HTTP_AUTH_BASE64=$(echo -ne "${NGINX_SERVICE_ACCOUNT_USERNAME}:${NGINX_SERVICE_ACCOUNT_PASSWORD}" | base64 -w 0)
envsubst '${ELASTIC_USERNAME} ${NGINX_SERVICE_ACCOUNT_HTTP_AUTH_BASE64}' < /tmp/default.conf > /etc/nginx/conf.d/default.conf

# Generate basic authenticate credential
htpasswd -b -c /etc/nginx/secrets/.htpasswd ${NGINX_BASIC_AUTH_USERNAME:-nousername} ${NGINX_BASIC_AUTH_PASSWORD:-nopassword}

# If no need basic authenticate
if [[ -z "${NGINX_BASIC_AUTH_USERNAME}" || -z "${NGINX_BASIC_AUTH_PASSWORD}" ]]; then
    # Turn off basic authenticate
    sed -i 's/"Basic Authenticate"/"off"/' /etc/nginx/conf.d/default.conf
else
    # Turn on basic authenticate
    sed -i 's/"off"/"Basic Authenticate"/' /etc/nginx/conf.d/default.conf
fi

nginx -g 'daemon off;'
