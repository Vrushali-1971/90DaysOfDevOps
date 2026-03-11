# Day 19 – Shell Scripting Project: Log Rotation, Backup & Crontab

### Overview

Applied everything from Days 16–18 in real-world mini projects:
- Log rotation script
- Server backup script
- Crontab scheduling
- Combined maintenance script


## Task 1: Log Rotation Script — `log_rotate.sh`

### Script

```bash
#!/bin/bash

# Argument
LOG_DIR="$1"

# Validate argument count
if [ $# -ne 1 ]; then
    echo "Usage: $0 <log_directory>"
    exit 1
fi

# Check log directory exists
if [ ! -d "$LOG_DIR" ]; then
    echo "Error: Directory '$LOG_DIR' does not exist."
    exit 1
fi

# Compress .log files older than 7 days
COMPRESSED=0

while IFS= read -r file; do
    gzip "$file"
    COMPRESSED=$((COMPRESSED + 1))
done < <(find "$LOG_DIR" -name "*.log" -mtime +7)

# Delete .gz files older than 30 days
DELETED=0

while IFS= read -r file; do
    rm "$file"
    DELETED=$((DELETED + 1))
done < <(find "$LOG_DIR" -name "*.gz" -mtime +30)

# Print summary
echo "Log rotation complete!"
echo "Files compressed : $COMPRESSED"
echo "Files deleted    : $DELETED"
```

### Sample Output

```
Log rotation complete!
Files compressed : 0
Files deleted    : 0
```

#### How to Run

```
chmod +x log_rotate.sh
sudo ./log_rotate.sh /var/log/nginx
```

## Task 2: Server Backup Script — `backup.sh`

### Script

```bash
#!/bin/bash

# Arguments
SRC_DIR="$1"
DEST_DIR="$2"

# Validate argument count
if [ $# -ne 2 ]; then
    echo "Usage: $0 <source_dir> <backup_destination>"
    exit 1
fi

# Check source exists
if [ ! -d "$SRC_DIR" ]; then
    echo "Error: Source directory '$SRC_DIR' does not exist."
    exit 1
fi

# Create destination if missing
mkdir -p "$DEST_DIR"

# Create timestamp and archive name
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
ARCHIVE_NAME="backup-${TIMESTAMP}.tar.gz"
BACKUP_FILE="${DEST_DIR}/${ARCHIVE_NAME}"

# Create the .tar.gz archive
tar -czf "$BACKUP_FILE" -C "$(dirname "$SRC_DIR")" "$(basename "$SRC_DIR")"

# Verify archive was created successfully
if [ ! -f "$BACKUP_FILE" ]; then
    echo "Error: Backup failed. Archive was not created."
    exit 1
fi

# Print archive name and size
ARCHIVE_SIZE=$(du -sh "$BACKUP_FILE" | cut -f1)
echo "Backup successful!"
echo "Archive : $BACKUP_FILE"
echo "Size    : $ARCHIVE_SIZE"

# Delete backups older than 14 days
echo "Cleaning up backups older than 14 days..."
find "$DEST_DIR" -name "backup-*.tar.gz" -mtime +14 -delete
echo "Cleanup done."
```

### Sample Output

```
Backup successful!
Archive : /home/ubuntu/backups/backup-2026-03-11_18-33-43.tar.gz
Size    : 4.0K
Cleanup done.
```

#### How to Run

```
chmod +x backup.sh
./backup.sh ~/scripts ~/backups
```

## Task 3: Crontab

#### What was scheduled before

`no crontab for ubuntu`

#### Nothing was scheduled — fresh start.

### Cron Syntax

```
* * * * *  command
│ │ │ │ │
│ │ │ │ └── Day of week (0-7, 0=Sunday)
│ │ │ └──── Month (1-12)
│ │ └────── Day of month (1-31)
│ └──────── Hour (0-23)
└────────── Minute (0-59)
```
### Cron Entries Written

```bash
# Run log_rotate.sh every day at 2 AM
0 2 * * * /home/ubuntu/log_rotate.sh /var/log/nginx

# Run backup.sh every Sunday at 3 AM
0 3 * * 0 /home/ubuntu/scripts/backup.sh /home/ubuntu/scripts /home/ubuntu/backups

# Run health check every 5 minutes
*/5 * * * * /home/ubuntu/health_check.sh

# Run maintenance.sh every day at 1 AM
0 1 * * * /home/ubuntu/maintenance.sh
```

## Task 4: Maintenance Script — `maintenance.sh`

### Script

```bash
#!/bin/bash

# Log file
LOG_FILE="/var/log/maintenance.log"
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

# Logging function
log() {
    echo "[$TIMESTAMP] $1" | tee -a "$LOG_FILE"
}

# Start
log "===== Maintenance started ====="

# Step 1: Run log rotation
log "Starting log rotation..."
/home/ubuntu/log_rotate.sh /var/log/nginx >> "$LOG_FILE" 2>&1
log "Log rotation done."

# Step 2: Run backup
log "Starting backup..."
/home/ubuntu/scripts/backup.sh /home/ubuntu/scripts /home/ubuntu/backups >> "$LOG_FILE" 2>&1
log "Backup done."

# End
log "===== Maintenance complete ====="
```

### Sample Output

```
[2026-03-11 18:50:17] ===== Maintenance started =====
[2026-03-11 18:50:17] Starting log rotation...
[2026-03-11 18:50:17] Log rotation done.
[2026-03-11 18:50:17] Starting backup...
[2026-03-11 18:50:17] Backup done.
[2026-03-11 18:50:17] ===== Maintenance complete =====
```

#### How to Run

```
chmod +x maintenance.sh
sudo ./maintenance.sh
```

### Cron Entry
```bash
# Run maintenance.sh every day at 1 AM
0 1 * * * /home/ubuntu/maintenance.sh
```

### What I Learned

- find with -mtime and -delete — You can search for files by age and act on them in one command.

  -mtime +7 means older than 7 days, + means older, - means newer.
- tar -czf with -C and basename — Creating clean archives requires changing into the parent directory first with -C $(dirname $SRC)

   so the archive doesn't store the full absolute path inside.
- 2>&1 and tee -a — Redirecting both stdout and stderr to a log file ensures errors are captured too.

   tee -a lets you print to terminal AND append to a f
