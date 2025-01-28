#!/bin/bash

# Variables
INTEGRATION_NODE="${INTEGRATION_NODE:-IN7}"         # Default node name
INTEGRATION_SERVER="${INTEGRATION_SERVER:-IE7}"    # Default server name
WORKSPACE_DIR="${WORKSPACE_DIR:-/home/ace/IBM/ACET12/workspace}" # Default workspace directory
BAR_FILE_NAME="${BAR_FILE_NAME:-static_app-demo.bar}"  # Default BAR file name
BAR_FILE_DIR="${BAR_FILE_DIR:-/home/ace/bar-files}"   # Directory for storing BAR files
BAR_FILE="$BAR_FILE_DIR/$BAR_FILE_NAME"              # Full path to BAR file
APPLICATION_NAME="${APPLICATION_NAME:-static_app_workspace}" # Default application/library name

LOG_FILE="/tmp/build.log"                  # Log file location

# Ensure the log file is clean before each run
> $LOG_FILE

echo "Generating BAR file for $APPLICATION_NAME..." | tee -a $LOG_FILE

# Ensure the BAR file directory exists
if [ ! -d "$BAR_FILE_DIR" ]; then
  echo "BAR file directory '$BAR_FILE_DIR' does not exist. Creating it now..." | tee -a $LOG_FILE
  mkdir -p "$BAR_FILE_DIR"
fi

# Generate BAR file
mqsicreatebar -data "$WORKSPACE_DIR" -b "$BAR_FILE" -a "$APPLICATION_NAME" 2>&1 | tee -a $LOG_FILE

# Check if BAR file creation was successful
if [ $? -ne 0 ]; then
  echo "Error: BAR file generation failed. Check the log: $LOG_FILE" | tee -a $LOG_FILE
  exit 1
fi

echo "BAR file generated successfully: $BAR_FILE" | tee -a $LOG_FILE
exit 0

