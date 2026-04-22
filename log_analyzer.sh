#!/bin/bash

# Nginx Log Analyzer
# This script analyzes nginx access logs to provide insights on requests.

# Check if log file is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <nginx-access-log-file>"
    exit 1
fi

LOG_FILE=$1

# Check if file exists
if [ ! -f "$LOG_FILE" ]; then
    echo "Error: File '$LOG_FILE' not found."
    exit 1
fi

echo "Analyzing $LOG_FILE..."
echo ""

# Function to display top 5 of a specific field
# $1: Field name for display
# $2: Command to extract the field
analyze_field() {
    local label=$1
    local extract_cmd=$2

    echo "$label:"
    # Use awk to handle the count and the rest of the line correctly
    eval "$extract_cmd" | sort | uniq -c | sort -rn | head -5 | \
    awk '{
        count = $1;
        $1 = "";
        # Trim leading space from $0 after removing $1
        line = substr($0, 2);
        print line " - " count " requests";
    }'
    echo ""
}

# 1. Top 5 IP addresses
analyze_field "Top 5 IP addresses with the most requests" "awk '{print \$1}' $LOG_FILE"

# 2. Top 5 most requested paths
analyze_field "Top 5 most requested paths" "awk -F'\"' '{print \$2}' $LOG_FILE | awk '{print \$2}'"

# 3. Top 5 response status codes
analyze_field "Top 5 response status codes" "awk -F'\"' '{print \$3}' $LOG_FILE | awk '{print \$1}'"

# 4. Top 5 user agents
analyze_field "Top 5 user agents" "awk -F'\"' '{print \$6}' $LOG_FILE"

# Stretch Goal: Multiple Solutions
# ---------------------------------------------------------
# Here are some alternative ways to achieve the same results:

# Alternative for IP addresses (using cut):
# cut -d' ' -f1 "$LOG_FILE" | sort | uniq -c | sort -rn | head -5

# Alternative for status codes (using grep and sed):
# grep -o '" [0-9]\{3\} ' "$LOG_FILE" | sed 's/" //' | sort | uniq -c | sort -rn | head -5

# Alternative for paths (using sed):
# sed -E 's/.*"GET ([^ ]+) HTTP.*/\1/' "$LOG_FILE" | sort | uniq -c | sort -rn | head -5

