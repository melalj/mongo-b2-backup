#!/bin/bash

set -e

SCRIPT_NAME=restore-mongodb


echo "[$SCRIPT_NAME] Authorizing B2 account"
b2 authorize-account ${B2_ACCOUNT_ID} ${B2_ACCESS_KEY}

echo "[$SCRIPT_NAME] Downloading ${RESTORE_ARCHIVE_NAME} from ${B2_BUCKET}..."
b2 download-file-by-id --noProgress ${B2_BUCKET} ${RESTORE_ARCHIVE_NAME} ${RESTORE_ARCHIVE_NAME}

echo "[$SCRIPT_NAME] Restore MongoDB databases ${DB_NAME} from compressed archive..."

mongorestore "${RESTORE_EXTRA_PARAMS}" \
	--authenticationDatabase "$AUTH_DB_NAME" \
	--nsInclude="$DB_NAME" \
	--uri "$MONGODB_URI" \
	--gzip \
	--archive="$RESTORE_ARCHIVE_NAME"


echo "[$SCRIPT_NAME] Cleaning up compressed archive..."
rm "$RESTORE_ARCHIVE_NAME"

echo "[$SCRIPT_NAME] restore complete!"
