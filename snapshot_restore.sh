#!/bin/bash

# Load config
source config.env

echo "Restoring latest snapshot..."

case $CLOUD_PROVIDER in
  aws)
    LATEST_SNAPSHOT=$(aws ec2 describe-snapshots --owner self --region $AWS_REGION --query 'Snapshots | sort_by(@, &StartTime) | [-1].SnapshotId' --output text)
    echo "Restoring from AWS snapshot: $LATEST_SNAPSHOT"
    ;;
    
  gcp)
    gcloud compute disks create restored-disk --source-snapshot="backup-$(date +%F)" --zone=$GCP_ZONE --project=$GCP_PROJECT_ID
    echo "Restored GCP VM disk from snapshot."
    ;;
    
  azure)
    az disk create --resource-group $AZURE_RESOURCE_GROUP --name restored-disk --source "backup-$(date +%F)"
    echo "Restored Azure VM disk from snapshot."
    ;;
    
  *)
    echo "Invalid cloud provider specified in config.env"
    ;;
esac
