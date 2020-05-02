FROM nginx:1.17.9-alpine

# Set default argument variables
ARG APP_PATH=/app
ARG NGINX_BASIC_AUTH_USERNAME
ARG NGINX_BASIC_AUTH_PASSWORD

# Binding argument variables to environment variables
ENV NGINX_BASIC_AUTH_USERNAME=${NGINX_BASIC_AUTH_USERNAME} NGINX_BASIC_AUTH_PASSWORD=${NGINX_BASIC_AUTH_PASSWORD}

# Install dependencies
RUN apk add --update bash libintl openssl tzdata apache2-utils coreutils curl jq && \
    apk add --virtual build_deps gettext && \
    cp /usr/bin/envsubst /usr/local/bin/envsubst && \
    apk del build_deps && \
    rm -rf /var/cache/apk/*

# Set our working directory inside the image
WORKDIR ${APP_PATH}

# Create cert directory
RUN mkdir -p /etc/nginx/secrets

# Copy all command scripts
COPY command.sh /command.sh

# Copy Nginx config template
COPY default.conf /tmp/

EXPOSE 80
