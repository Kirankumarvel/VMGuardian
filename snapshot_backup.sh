#!/bin/bash

# Load config
source config.env

echo "Starting VM snapshot backup..."

case $CLOUD_PROVIDER in
  aws)
    SNAPSHOT_ID=$(aws ec2 create-snapshot --volume-id $(aws ec2 describe-instances --instance-ids $AWS_INSTANCE_ID --query 'Reservations[].Instances[].BlockDeviceMappings[].Ebs.VolumeId' --output text) --description "Automated Backup $(date +%F)" --region $AWS_REGION --query 'SnapshotId' --output text)
    echo "AWS Snapshot created: $SNAPSHOT_ID"
    ;;
    
  gcp)
    gcloud compute disks snapshot $GCP_INSTANCE_NAME --snapshot-names="backup-$(date +%F)" --zone=$GCP_ZONE --project=$GCP_PROJECT_ID
    echo "GCP Snapshot created: backup-$(date +%F)"
    ;;
    
  azure)
    az snapshot create --resource-group $AZURE_RESOURCE_GROUP --name "backup-$(date +%F)" --source $AZURE_VM_NAME
    echo "Azure Snapshot created: backup-$(date +%F)"
    ;;
    
  *)
    echo "Invalid cloud provider specified in config.env"
    ;;
esac
