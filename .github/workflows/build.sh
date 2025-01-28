#!/bin/bash

# Variables
# Input variables
INTEGRATION_NODE="${INTEGRATION_NODE:-IN7}"         # Default node name
INTEGRATION_SERVER="${INTEGRATION_SERVER:-IE7}" # Default server name
WORKSPACE_DIR="${WORKSPACE_DIR:-/home/ace/IBM/ACET12/workspace}" # Default workspace directory
BAR_FILE_NAME="${BAR_FILE_NAME:-static_app-demo}# Default BAR file name
BAR_FILE_DIR="/home/ace/bar-files"                 # Directory for storing BAR files
BAR_FILE="$BAR_FILE_DIR/$BAR_FILE_NAME"            # Full path to BAR file
APPLICATION_NAME="${APPLICATION_NAME:-static static_app_workspace}" # Default application/library name
OVERRIDE_FILE="${OVERRIDE_FILE}"                   # Optional override file

LOG_FILE="/var/log/ace/build.log"       # Log file location

# Clean log file for every commit
> $LOG_FILE

echo "Generating BAR file for $APPLICATION_NAME..." | tee -a $LOG_FILE

# Generate BAR file
mqsicreatebar -data "$WORKSPACE_DIR" -b "$BAR_FILE" -a "$APPLICATION_NAME" 2>&1 | tee -a $LOG_FILE

# Check if BAR file creation was successful
if [ $? -ne 0 ]; then
  echo "Error: BAR file generation failed. Check the log: $LOG_FILE" | tee -a $LOG_FILE
  exit 1
fi

echo "BAR file generated successfully: $BAR_FILE" | tee -a $LOG_FILE
exit 0

