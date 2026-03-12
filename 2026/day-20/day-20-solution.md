# Day 20 – Bash Scripting Challenge: Log Analyzer and Report Generator

## Overview

Built a `log_analyzer.sh` script that automates the process of analyzing log files, identifying errors and critical events, generating a summary report, and archiving processed logs.

---

### Script: `log_analyzer.sh`

```bash
#!/bin/bash

# ─── Task 1: Input and Validation ────────────────────────
LOG_FILE_PATH="$1"

if [ $# -ne 1 ]; then
    echo "Usage: ./log_analyzer.sh <path_to_log_file>"
    exit 1
fi

if [ ! -f "$LOG_FILE_PATH" ]; then
    echo "Error: File does not exist."
    exit 1
fi

# ─── Task 2: Error Count ──────────────────────────────────
ERROR_COUNT=$(grep -cE 'ERROR|Failed' "$LOG_FILE_PATH")
echo "Total error count: $ERROR_COUNT"

# ─── Task 3: Critical Events ─────────────────────────────
echo "--- Critical Events ---"
KEYWORD=$(awk '/CRITICAL/ {print "Line "NR": "$0}' "$LOG_FILE_PATH")
echo "$KEYWORD"

# ─── Task 4: Top 5 Error Messages ────────────────────────
echo "---- Top 5 Error Messages ----"
ERROR=$(grep 'ERROR' "$LOG_FILE_PATH" | awk '{$1=$2=$3=$NF=""; print}' | sort | uniq -c | sort -rn | head -5)
echo "$ERROR"

# ─── Task 5: Summary Report ───────────────────────────────
DATE=$(date +"%Y-%m-%d")
REPORT_FILE="log_report_${DATE}.txt"
TOTAL_LINES=$(wc -l < "$LOG_FILE_PATH")
LOG_NAME=$(basename "$LOG_FILE_PATH")

{
    echo "===== Log Analysis Report ====="
    echo "Date of analysis  : $DATE"
    echo "Log file name     : $LOG_NAME"
    echo "Total lines       : $TOTAL_LINES"
    echo "Total error count : $ERROR_COUNT"
    echo ""
    echo "---- Top 5 Error Messages ----"
    echo "$ERROR"
    echo ""
    echo "----- Critical Events -----"
    echo "$KEYWORD"
} > "$REPORT_FILE"

echo "Report saved to: $REPORT_FILE"

# ─── Task 6: Archive Processed Log ───────────────────────
ARCHIVE_DIR="$(dirname "$LOG_FILE_PATH")/archive"

mkdir -p "$ARCHIVE_DIR"
mv "$LOG_FILE_PATH" "$ARCHIVE_DIR/"
echo "Log file moved to $ARCHIVE_DIR/"
```

---

## How to Run

```bash
# Step 1 - Generate sample log
cd ~/90DaysOfDevOps/2026/day-20
./sample_logs_generator.sh sample_log.log 500

# Step 2 - Run analyzer
~/log_analyzer.sh ~/90DaysOfDevOps/2026/day-20/sample_log.log
```

---

## Sample Output

### Terminal Output

```
---- Top 5 Error Messages ----
     32    Failed to connect -
     30    Out of memory -
     25    Segmentation fault -
     14    Invalid input -
     12    Disk full -
Report saved to: log_report_2026-03-12.txt
Log file moved to /home/ubuntu/90DaysOfDevOps/2026/day-20/archive/
```

### Critical Events (sample)

```
Line 1:   2026-03-12 13:26:16 [CRITICAL] - 7423
Line 7:   2026-03-12 13:26:16 [CRITICAL] - 2077
Line 15:  2026-03-12 13:26:16 [CRITICAL] - 22788
Line 23:  2026-03-12 13:26:16 [CRITICAL] - 20229
Line 28:  2026-03-12 13:26:16 [CRITICAL] - 18619
Line 33:  2026-03-12 13:26:16 [CRITICAL] - 13495
Line 34:  2026-03-12 13:26:16 [CRITICAL] - 7030
Line 35:  2026-03-12 13:26:16 [CRITICAL] - 16463
Line 38:  2026-03-12 13:26:16 [CRITICAL] - 7503
Line 42:  2026-03-12 13:26:16 [CRITICAL] - 16139
...
```

---

## Generated Report: `log_report_2026-03-12.txt`

```
===== Log Analysis Report =====
Date of analysis  : 2026-03-12
Log file name     : sample_logs.log
Total lines       : 500
Total error count : 113

---- Top 5 Error Messages ----
     32    Failed to connect -
     30    Out of memory -
     25    Segmentation fault -
     14    Invalid input -
     12    Disk full -

----- Critical Events -----
Line 1:   2026-03-12 13:26:16 [CRITICAL] - 7423
Line 7:   2026-03-12 13:26:16 [CRITICAL] - 2077
Line 15:  2026-03-12 13:26:16 [CRITICAL] - 22788
Line 23:  2026-03-12 13:26:16 [CRITICAL] - 20229
Line 28:  2026-03-12 13:26:16 [CRITICAL] - 18619
Line 33:  2026-03-12 13:26:16 [CRITICAL] - 13495
Line 34:  2026-03-12 13:26:16 [CRITICAL] - 7030
Line 35:  2026-03-12 13:26:16 [CRITICAL] - 16463
Line 38:  2026-03-12 13:26:16 [CRITICAL] - 7503
Line 42:  2026-03-12 13:26:16 [CRITICAL] - 16139
Line 47:  2026-03-12 13:26:16 [CRITICAL] - 11021
Line 56:  2026-03-12 13:26:16 [CRITICAL] - 19344
Line 57:  2026-03-12 13:26:16 [CRITICAL] - 32553
Line 58:  2026-03-12 13:26:16 [CRITICAL] - 17654
Line 63:  2026-03-12 13:26:16 [CRITICAL] - 22004
Line 67:  2026-03-12 13:26:16 [CRITICAL] - 7033
Line 77:  2026-03-12 13:26:16 [CRITICAL] - 15401
Line 86:  2026-03-12 13:26:16 [CRITICAL] - 7870
...
```

---

## Commands and Tools Used

**`grep`** — searched for patterns like `ERROR`, `Failed`, `CRITICAL` inside the log file. Used `-c` flag to count matching lines and `-E` for extended regex to match multiple patterns at once.

**`awk`** — used for two purposes: extracting lines matching `CRITICAL` with their line numbers using `NR`, and stripping timestamp and log level fields from error lines to isolate the actual error message.

**`sort`** — grouped identical error messages together so `uniq -c` could count them correctly. Without sorting first, duplicate lines spread across the file would not be counted together.

**`uniq -c`** — counted consecutive identical lines after sorting, giving the occurrence count of each unique error message.

**`wc -l`** — counted total lines in the log file for the summary report.

**`basename`** — extracted just the filename from a full path for display in the report.

**`dirname`** — extracted the directory part of the log file path to create the archive folder next to the log file.

**`{ } > file`** — grouped multiple echo commands and redirected all their output into a single report file in one operation.

---

## What I Learned

1. **`sort` must come before `uniq -c`** — `uniq -c` only counts consecutive identical lines. Without sorting first, duplicate error messages spread across the file are treated as separate entries and each gets a count of 1. Sorting groups them together first so `uniq -c` counts them correctly.

2. **`awk` field manipulation** — Setting fields to empty with `$1=$2=$3=""` strips unwanted parts of a line. Setting `$NF=""` removes the last field. This lets you isolate just the meaningful part of a log line without the timestamp and random numbers that would make every line look unique.

3. **Relative vs absolute paths matter in scripts** — Using `archive` as a relative path creates the folder wherever the script is run from, not where the log file is. Using `$(dirname "$LOG_FILE_PATH")/archive` always creates the archive folder next to the log file regardless of where you run the script from. 
