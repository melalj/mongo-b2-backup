# Schedule MongoDB Backup to B2 BackBlaze

By default the script will run every day at 12PM UTC.

If you'd like to run specific tasks:

The tasks will run every day `0 12 * * *`

## Backup

```sh
AUTH_DB_NAME=""
BACKUP_EXTRA_PARAMS=""
DB_NAME=""
MONGODB_URI="mongodb://..."
B2_BUCKET=""
B2_ACCOUNT_ID=""
B2_ACCESS_KEY=""

# Change the ENTRYPOINT to 
/scripts/backup.sh
```

## Restore

```sh
RESTORE_ARCHIVE_NAME=""
RESTORE_EXTRA_PARAMS="--drop"
AUTH_DB_NAME=""
DB_NAME=""
MONGODB_URI="mongodb://..."
B2_BUCKET=""
B2_ACCOUNT_ID=""
B2_ACCESS_KEY=""

# Change the ENTRYPOINT to 
/scripts/restore.sh
```
