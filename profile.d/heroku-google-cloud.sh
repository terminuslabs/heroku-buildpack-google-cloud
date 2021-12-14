#!/usr/bin/env bash

# Add gcloud to PATH
export PATH=/app/vendor/google-cloud-sdk/bin:$PATH

if [ -z "$GOOGLE_CREDENTIALS" ]; then
    echo "GOOGLE_CREDENTIALS not set"
else
    export GOOGLE_APPLICATION_CREDENTIALS='/app/google-credentials.json'
    echo "$GOOGLE_CREDENTIALS" | base64 -d > $GOOGLE_APPLICATION_CREDENTIALS
    gcloud config set container/use_application_default_credentials true
    gcloud auth activate-service-account --key-file /app/google-credentials.json
    gcloud container clusters get-credentials autopilot-cluster-1 --region=us-central1 --project=terminus-docker
fi

# Set default project and compute zone
#if [ ! -z $PROJECT ]; then
#    gcloud config set project $PROJECT
#fi
#if [ ! -z $ZONE ]; then
#    gcloud config set compute/zone $ZONE
#fi
