#!/bin/bash

trap "break;exit" SIGHUP SIGINT SIGTERM
set -e

while /bin/true; do
  SCRIPT_NAME=backup-mongodb
  ARCHIVE_NAME=${DB_NAME}_$(date +%Y%m%d_%H%M%S).gz

  echo "[$SCRIPT_NAME] Authorizing B2 account"
  b2 authorize-account ${B2_ACCOUNT_ID} ${B2_ACCESS_KEY}


  echo "[$SCRIPT_NAME] Dumping MongoDB databases ${DB_NAME} to compressed archive..."
  mongodump "${RESTORE_EXTRA_PARAMS}" \
    --authenticationDatabase "$AUTH_DB_NAME" \
    --db "$DB_NAME" \
    --archive="$ARCHIVE_NAME" \
    --gzip \
    --uri "$MONGODB_URI"

  echo "[$SCRIPT_NAME] Uploading ${ARCHIVE_NAME} to S3 bucket..."
  b2 upload-file --sha1 --noProgress $(sha1sum $ARCHIVE_NAME | awk '{print $1}') ${B2_BUCKET} $ARCHIVE_NAME $ARCHIVE_NAME

  echo "[$SCRIPT_NAME] Cleaning up compressed archive..."
  rm "$ARCHIVE_NAME"

  echo "[$SCRIPT_NAME] Backup complete!"

  sleep 1d
done