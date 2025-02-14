#!/bin/bash

# Configuration
SOURCE_DIR="$HOME"  # Source directory (your home folder)
DEST_DIR="/backup"   # Destination directory (/backup folder)
LOG_FILE="/var/log/home_backup.log" # Log file location
RSYNC_OPTIONS="-avz --delete --exclude='.cache' --exclude='.local/share/Trash'" # Rsync options

# Function to log messages
log_message() {
  timestamp=$(date +"%Y-%m-%d %H:%M:%S")
  echo "[$timestamp] $1" >> "$LOG_FILE"
}

# Check if the destination directory exists
if [ ! -d "$DEST_DIR" ]; then
  log_message "Error: Destination directory '$DEST_DIR' does not exist. Creating it."
  mkdir -p "$DEST_DIR"
  if [ ! -d "$DEST_DIR" ]; then
       log_message "Error: Failed to create destination directory '$DEST_DIR'."
       exit 1
  fi
fi


# Rsync command
rsync "$RSYNC_OPTIONS" "$SOURCE_DIR" "$DEST_DIR"

# Check the exit status of rsync
if [ $? -eq 0 ]; then
  log_message "Home folder synced successfully to '$DEST_DIR'."
else
  log_message "Error: Home folder sync failed."
fi

# Cleanup old logs (optional - keep only the last 7 days)
find "$LOG_FILE" -type f -mtime +7 -delete

exit 0