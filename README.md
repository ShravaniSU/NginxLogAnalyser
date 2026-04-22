# Nginx Log Analyzer

A simple shell script to analyze Nginx access logs from the command line. This tool helps you quickly identify top contributors to your web traffic, most requested resources, and common response statuses.

## Features

The script provides the following information from any standard Nginx access log:
- **Top 5 IP addresses** with the most requests.
- **Top 5 most requested paths**.
- **Top 5 response status codes**.
- **Top 5 user agents**.

## Prerequisites

The script uses standard Unix utilities that are available on most Linux/macOS systems:
- `bash`
- `awk`
- `sort`
- `uniq`
- `head`

## Usage

1. **Make the script executable**:
   ```bash
   chmod +x log_analyzer.sh
   ```

2. **Run the script** by providing the path to your Nginx access log file:
   ```bash
   ./log_analyzer.sh nginx-access.log
   ```

## Sample Output

```text
Analyzing nginx-access.log...

Top 5 IP addresses with the most requests:
178.128.94.113 - 1087 requests
142.93.136.176 - 1087 requests
...

Top 5 most requested paths:
/v1-health - 4560 requests
/ - 270 requests
...

Top 5 response status codes:
200 - 5740 requests
404 - 937 requests
...

Top 5 user agents:
DigitalOcean Uptime Probe 0.22.0 (https://digitalocean.com) - 4347 requests
...
```

## Advanced Usage (Stretch Goal)

The script implementation primarily uses `awk` for its flexibility and power in parsing structured text. However, the project also explores alternative ways to filter and count requests.

Check the comments at the end of `log_analyzer.sh` to see examples of how to achieve similar results using:
- `cut` (for simple field extraction)
- `grep` & `sed` (for pattern-based extraction)

---
*This project is part of a DevOps practice roadmap from [roadmap.sh](https://roadmap.sh/projects/nginx-log-analyser).*

