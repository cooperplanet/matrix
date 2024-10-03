# Start from the official Synapse image
FROM docker.io/matrixdotorg/synapse:latest

# Install required packages: gettext for envsubst and git for cloning the user restrictions module
RUN apt-get update && apt-get install -y gettext git && rm -rf /var/lib/apt/lists/*

# Install synapse-user-restrictions module
RUN git clone https://github.com/matrix-org/synapse-user-restrictions.git /synapse-user-restrictions && \
    pip install /synapse-user-restrictions && \
    rm -rf /synapse-user-restrictions

# Create a directory to store the homeserver.yaml template
RUN mkdir -p /templates

# Copy the homeserver.yaml template to the templates directory
COPY homeserver.yaml /templates/homeserver.yaml

# Copy the entrypoint script into the container
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Use the custom entrypoint script
ENTRYPOINT ["/entrypoint.sh"]
