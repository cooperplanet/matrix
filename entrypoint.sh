#!/bin/sh

if [ -f "/templates/.env" ]; then
  export $(grep -v '^#' /templates/.env | xargs)
fi

envsubst < /templates/config.yaml > /mas/config.yaml
envsubst < /templates/homeserver.yaml > /data/homeserver.yaml
cp /templates/key1.pem /mas/key1.pem