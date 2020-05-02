# Container Logger

Fast configuration for store and view container logs

## Stack

- Elasticsearch 7.6.2
- Kibana 7.6.2
- Logstash 7.6.2
- Filebeat 7.6.2
- Metricbeat 7.6.2
- Curator 5.8.0
- Nginx 1.17.9

## Features

- Basic authenticate with Nginx.
  - You can turn off basic authenticate by leave `NGINX_BASIC_AUTH_USERNAME=` or `NGINX_BASIC_AUTH_PASSWORD=` empty
  - Use a reverse proxy to handle X-Pack authentication with impersonation feature
- Rotate `filebeat-*` and `metricbeat-*` index when creation date older than `METRICBEAT_CURATOR_UNIT_COUNT`, `FILEBEAT_CURATOR_UNIT_COUNT`.
- Centralize docker container logs with one command:
  `$ docker-compose up`
