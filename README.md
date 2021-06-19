# Schedule MongoDB Backup to B2 BackBlaze

## Backup

```sh
AUTH_DB_NAME=""
BACKUP_EXTRA_PARAMS=""
DB_NAME=""
MONGODB_URI="mongodb://..."
B2_BUCKET=""
B2_ACCOUNT_ID=""
B2_ACCESS_KEY=""
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
/scripts/restore.sh
```
