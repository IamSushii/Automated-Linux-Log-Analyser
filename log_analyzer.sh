#!/bin/bash

# Define variables
LOG_FILE="server_logs.txt"
REPORT_FILE="daily_health_report.txt"
DATE=$(date +"%Y-%m-%d")

echo "Starting Server Health Analysis for $DATE..."

# 1. Count the Total Errors
TOTAL_500=$(grep -c "500 ERROR" $LOG_FILE)
TOTAL_401=$(grep -c "401 UNAUTHORIZED" $LOG_FILE)

# 2. Generate the Report
echo "--- SERVER HEALTH REPORT: $DATE ---" > $REPORT_FILE
echo "Critical Crashes (500 Errors): $TOTAL_500" >> $REPORT_FILE
echo "Failed Logins (401 Errors): $TOTAL_401" >> $REPORT_FILE

echo "Report generated successfully! Archiving old logs..."

# 3. Archive (Zip) the original log file to save space
tar -czf logs_archive_$DATE.tar.gz $LOG_FILE

# 4. Clear the original log file for tomorrow
> $LOG_FILE

echo "Process Complete. Read your report using 'cat $REPORT_FILE'."
