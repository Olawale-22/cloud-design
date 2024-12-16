# Use an appropriate base image
FROM ubuntu:20.04

# Install necessary packages
RUN apt-get update && \
    apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common && \
    curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | apt-key add - && \
    echo "deb https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /" | tee /etc/apt/sources.list.d/kubernetes.list && \
    apt-get update && \
    apt-get install -y \
    vagrant \
    virtualbox \
    kubectl \
    prometheus \
    && apt-get clean

# Copy the orchestrator folder to the container
COPY orchestrator /orchestrator

# Copy the Prometheus configuration file to the container
COPY prometheus.yml /etc/prometheus/prometheus.yml

# Set the working directory
WORKDIR /orchestrator

# Make the orchestrator.sh script executable
RUN chmod +x orchestrator.sh

# Define the entry point
ENTRYPOINT ["./orchestrator.sh"]