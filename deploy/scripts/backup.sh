#!/bin/bash

# Configuration
BACKUP_DIR="/Users/sovitkarki/backups"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="$BACKUP_DIR/db_backup_$TIMESTAMP.dump"
DB_NAME="postgres"
DB_USER="KARKI"
LOG_FILE="$BACKUP_DIR/backup_$TIMESTAMP.log"

# Ensure backup directory exists
mkdir -p "$BACKUP_DIR"

# Logging function
log() {
    echo "[$(date +"%Y-%m-%d %H:%M:%S")] $1" | tee -a "$LOG_FILE"
}

# Start backup process
log "Starting PostgreSQL backup..."

# Check if pg_dump exists
if ! command -v pg_dump &> /dev/null; then
    log "ERROR: pg_dump not found. Please install PostgreSQL or add it to your PATH."
    exit 1
fi

# Run pg_dump
pg_dump -U "$DB_USER" -F c -f "$BACKUP_FILE" "$DB_NAME" 2>>"$LOG_FILE"

# Check if pg_dump was successful
if [ $? -eq 0 ]; then
    log "Backup successful: $BACKUP_FILE"
else
    log "ERROR: Backup failed. Check the log at $LOG_FILE"
    rm -f "$BACKUP_FILE"  # Remove incomplete backup
    exit 1
fi

