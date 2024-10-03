#!/bin/bash

# Export all environment variables from the .env file if it exists
if [ -f "/data/.env" ]; then
  export $(grep -v '^#' /data/.env | xargs)
fi

echo "Substituting environment variables into homeserver.yaml"
# Use envsubst to replace environment variables in homeserver.yaml
envsubst < /templates/homeserver.yaml > /data/homeserver.yaml

# Output the contents of the generated config file for debugging
echo "Contents of /data/homeserver.yaml:"
cat /data/homeserver.yaml

# Start the original Synapse entrypoint script to launch the service
exec /start.py
