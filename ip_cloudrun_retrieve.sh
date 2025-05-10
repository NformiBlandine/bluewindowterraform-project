#!/bin/bash

# === Input: Environment argument (e.g., dev, staging, prod) ===
ENV="$1"

# === Fixed configuration ===
PROJECT="bluewindow"                 # GCP project ID
REGION="us-central1"                 # Region where Cloud Run service is deployed
SERVICE="cloudrun-srv-$ENV"         # Full Cloud Run service name (with environment suffix)
LOG_FILE="cloud_run_ip.log"         # Log file name
TIME=$(date '+%Y-%m-%d %H:%M:%S')   # Current timestamp

# === Logging function ===
log() {
    echo "[$TIME] $1" | tee -a "$LOG_FILE"
}

# === Input validation ===
if [[ -z "$ENV" ]]; then
    log "Missing environment argument. Usage: $0 <env>"
    exit 1
fi

# === Get the Cloud Run service URL ===
URL=$(gcloud run services describe "$SERVICE" \
    --project="$PROJECT" \
    --region="$REGION" \
    --format="value(status.url)" 2>/dev/null)

# === Handle error if service not found or URL is empty ===
if [[ -z "$URL" ]]; then
    log "Failed to retrieve URL for service '$SERVICE'. Check service name, project, or region."
    exit 1
fi

# === Extract the hostname and resolve its public IP ===
HOSTNAME=$(echo "$URL" | sed 's|https://||')
IP=$(dig +short "$HOSTNAME" | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' | head -n1)

# === Handle error if IP resolution fails ===
if [[ -z "$IP" ]]; then
    log "Failed to resolve IP for hostname '$HOSTNAME'"
    exit 1
fi

# === Output and log result ===
log "Service: $SERVICE | URL: $URL | Public IP: $IP"
echo "$IP"

