#!/bin/bash

# Load config
source config.env

echo "Cleaning up old snapshots..."

case $CLOUD_PROVIDER in
  aws)
    aws ec2 describe-snapshots --owner self --region $AWS_REGION --query "Snapshots[?StartTime<'$(date -d "-$AWS_RETENTION_DAYS days" --utc +%Y-%m-%d)'].SnapshotId" --output text | while read SNAPSHOT_ID; do
      aws ec2 delete-snapshot --snapshot-id $SNAPSHOT_ID --region $AWS_REGION
      echo "Deleted AWS snapshot: $SNAPSHOT_ID"
    done
    ;;
    
  gcp)
    gcloud compute snapshots list --format="value(name,creationTimestamp)" --project=$GCP_PROJECT_ID | while read SNAPSHOT DATE; do
      if [[ $(date -d "$DATE" +%s) -lt $(date -d "-$GCP_RETENTION_DAYS days" +%s) ]]; then
        gcloud compute snapshots delete $SNAPSHOT --quiet --project=$GCP_PROJECT_ID
        echo "Deleted GCP snapshot: $SNAPSHOT"
      fi
    done
    ;;
    
  azure)
    az snapshot list --query "[?contains(name, 'backup-') && createdTime<'$(date -d "-$AZURE_RETENTION_DAYS days" +%Y-%m-%d)']" --output tsv | while read SNAPSHOT_ID; do
      az snapshot delete --resource-group $AZURE_RESOURCE_GROUP --name $SNAPSHOT_ID
      echo "Deleted Azure snapshot: $SNAPSHOT_ID"
    done
    ;;
    
  *)
    echo "Invalid cloud provider specified in config.env"
    ;;
esac
