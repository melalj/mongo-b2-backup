#!/bin/bash

set -e

SCRIPT_NAME=backup-mongodb
ARCHIVE_NAME=${DB_NAME}_$(date +%Y%m%d_%H%M%S).gz

echo "[$SCRIPT_NAME] Authorizing B2 account"
/usr/local/bin/b2 authorize-account ${B2_ACCOUNT_ID} ${B2_ACCESS_KEY}


echo "[$SCRIPT_NAME] Dumping MongoDB databases ${DB_NAME} to compressed archive..."
/usr/bin/mongodump "${RESTORE_EXTRA_PARAMS}" \
	--authenticationDatabase "$AUTH_DB_NAME" \
	--db "$DB_NAME" \
	--archive="$ARCHIVE_NAME" \
	--gzip \
	--uri "$MONGODB_URI"

echo "[$SCRIPT_NAME] Uploading ${ARCHIVE_NAME} to S3 bucket..."
/usr/local/bin/b2 upload-file --noProgress --sha1 $(sha1sum $ARCHIVE_NAME | awk '{print $1}') ${B2_BUCKET} $ARCHIVE_NAME $ARCHIVE_NAME

echo "[$SCRIPT_NAME] Cleaning up compressed archive..."
rm "$ARCHIVE_NAME"

echo "[$SCRIPT_NAME] Backup complete!"
exit 0
