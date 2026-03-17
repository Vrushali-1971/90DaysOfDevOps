# Day 21 - Shell Scripting Cheat Sheet

## A personal quick-reference guide built from Shell scripting learning over the last several days.

## Quick Reference Table

| Topic       |  Key Syntax              |   Example                            |
|-------------|--------------------------|--------------------------------------|
| Variable    |  VAR="value"             |   NAME="DevOps"                      | 
| Argument    |  $1, $2                  |   ./script.sh arg1                   |
| If          |  if [ condition ]; then  |   if [ -f file ]; then               |
| For loop    |  for i in list; do       |   for i in 1 2 3; do                 |
| While loop  |  while [ condition ]; do |   while [ $i -lt 5 ]; do             |
| Function    |  name() { ... }          |   greet() { echo "Hi"; }             |
| Grep        |  grep pattern file       |   grep -i "error" log.txt            |
| Awk         |  awk '{print $1}' file   |   awk -F: '{print $1}' /etc/passwd   |
| Sed         |  sed 's/old/new/g' file  |   sed -i 's/foo/bar/g' config.txt    |
| Exit code   |  $?                      |   echo $?  # 0 = success             |
| Trap        |  trap 'cmd' SIGNAL       |   trap 'cleanup' EXIT                |
| Debug       |  set -x                  |   set -euxo pipefail                 |

## 1. Basics

### Shebang

```bash
#!/bin/bash
```

Tells the OS which interpreter to use. Always the first line of a script.

`#!/usr/bin/env` bash is more portable across systems.

### Running a Script

```bash
chmod +x script.sh    # Make executable (only needed once)
./script.sh           # Run as executable
bash script.sh        # Run with bash directly (no chmod needed)
```

### Comments

```bash
# This is a single-line comment

echo "Hello"  # This is an inline comment
```

### Variables

```bash
NAME="DevOps"          # Declare (no spaces around =)
echo $NAME             # Use — basic
echo "$NAME"           # Use — safe, preserves whitespace (preferred)
echo '$NAME'           # Literal string — no expansion, prints: $NAME

FULL_PATH="$(pwd)/logs"  # Command substitution in variable
readonly PI=3.14          # Constant — cannot be changed
```

### Reading User Input

```bash
# -p: shows a prompt before reading input
read -p "Enter your name: " USERNAME
echo "Hello, $USERNAME"

# -s hides typed input (for passwords) 
read -sp "Enter password: " PASS  
```

### Command-Line Arguments

```bash
$0    # Script name itself
$1    # First argument
$2    # Second argument
$#    # Total number of arguments
$@    # All arguments (as separate words)
$?    # Exit code of the last command (0 = success)
$$    # PID of the current script
```

```bash
# Example
#!/bin/bash
echo "Script: $0"
echo "First arg: $1"
echo "All args: $@"
echo "Count: $#"
```

## 2. Operators and Conditionals

#### String Comparisons

```bash
[ "$a" = "$b" ]    # Equal
[ "$a" != "$b" ]   # Not equal
[ -z "$a" ]        # True if string is empty (zero length)
[ -n "$a" ]        # True if string is non-empty (non-zero length)
```

### Integer Comparisons

```bash
[ $a -eq $b ]    # Equal
[ $a -ne $b ]    # Not equal
[ $a -lt $b ]    # Less than
[ $a -gt $b ]    # Greater than
[ $a -le $b ]    # Less than or equal
[ $a -ge $b ]    # Greater than or equal
```

### File Test Operators

```bash
[ -f file ]    # True if file exists and is a regular file
[ -d dir ]     # True if directory exists
[ -e path ]    # True if path exists (file or directory)
[ -r file ]    # True if file is readable
[ -w file ]    # True if file is writable
[ -x file ]    # True if file is executable
[ -s file ]    # True if file exists and is non-empty
```

### if / elif / else

```bash
if [ "$USER" = "root" ]; then
    echo "You are root"
elif [ "$USER" = "vrush" ]; then
    echo "Hey Vrush!"
else
    echo "Unknown user"
fi
```

### Logical Operators

```bash
[ cond1 ] && [ cond2 ]   # AND — both must be true
[ cond1 ] || [ cond2 ]   # OR  — at least one must be true
[ ! cond ]               # NOT — negates the condition

# Inline usage
[ -d "/var/log" ] && echo "Log dir exists"
[ -f "config" ] || { echo "No config found"; exit 1; }
```

### Case Statement

```bash
case "$1" in
    start)
        echo "Starting service..."
        ;;
    stop)
        echo "Stopping service..."
        ;;
    restart)
        echo "Restarting service..."
        ;;
    *)
        echo "Usage: $0 {start|stop|restart}"
        exit 1
        ;;
esac
```

## 3. Loops

### for Loop — List-Based

```bash
for fruit in apple banana cherry; do
    echo "Fruit: $fruit"
done

# Loop over a range
for i in {1..5}; do
    echo "Count: $i"
done
```

### for Loop — C-Style

```bash
for (( i=0; i<5; i++ )); do
    echo "Index: $i"
done
```

### while Loop

```bash
COUNT=1
while [ $COUNT -le 5 ]; do
    echo "Count: $COUNT"
    (( COUNT++ ))
done
```

### until Loop

```bash
# Runs UNTIL the condition becomes true (opposite of while)
N=1
until [ $N -gt 5 ]; do
    echo "N = $N"
    (( N++ ))
done
```

### Loop Control

```bash
for i in {1..10}; do
    [ $i -eq 5 ] && break     # Stop loop at 5
    [ $i -eq 3 ] && continue  # Skip iteration 3
    echo "$i"
done
```

### Loop Over Files

```bash
for file in *.log; do
    echo "Processing: $file"
done
```

### Loop Over Command Output

```bash
# Read line-by-line from a command
df -h | while read line; do
    echo "$line"
done

# Or use a file
while read line; do
    echo "Host: $line"
done < servers.txt
```

## 4. Functions

### Defining and Calling a Function

```bash
greet() {
    echo "Hello, DevOps World!"
}

greet    # Call the function — no parentheses when calling
```

### Passing Arguments to Functions

```bash
# Fuction to check if a directory exists and create it if not
create_dir(){
    local dir_name=$1
    local permission=$2

    if [ -d "$dir_name" ]; then
        echo "Directory $dir_name already exists"
    else
        mkdir -p "$dir_name"
        chmod "$permission" "$dir_name"
        echo "Created $dir_name with permission $permission"
    fi
}

# Calling the function with argument
create_dir "/var/log/myapp" "755"
```

### Return Values

```bash
# return only returns exit codes (0–255), not strings
is_even() {
    [ $(( $1 % 2 )) -eq 0 ] && return 0 || return 1
}

is_even 4 && echo "Even" || echo "Odd"

# Use echo to return actual values
get_date() {
    echo "$(date +%Y-%m-%d)"
}

TODAY=$(get_date)
echo "Today is: $TODAY"
```

### Local Variables

```bash
# Without local, variables leak into global scope
calculate() {
    local result=$(( $1 + $2 ))   # local — only exists inside function
    echo "$result"
}

sum=$(calculate 10 20)
echo "Sum: $sum"
# $result is not accessible here
```

## 5. Text Processing Commands

### grep — Search Patterns

```bash
grep "error" app.log           # Basic search
grep -i "error" app.log        # -i: case-insensitive
grep -r "TODO" ./src/          # -r: recursive through directories
grep -c "error" app.log        # -c: count matching lines
grep -n "error" app.log        # -n: show line numbers
grep -v "debug" app.log        # -v: invert — exclude matching lines
grep -E "err(or)?" app.log     # -E: extended regex
grep -l "error" *.log          # -l: only filenames that match
```

### awk — Column Processing

```bash
awk '{print $1}' file.txt             # Print first column
awk '{print $1, $3}' file.txt         # Print columns 1 and 3
awk -F: '{print $1}' /etc/passwd      # -F: custom field separator (colon)
awk '$3 > 1000' /etc/passwd           # Print lines where col 3 > 1000
awk 'NR==5' file.txt                  # Print only line 5
awk 'BEGIN{print "Start"} {print} END{print "Done"}' file.txt
awk '{sum += $1} END {print sum}' nums.txt  # Sum a column
```

### sed — Stream Editor

```bash
sed 's/old/new/' file.txt          # Replace first occurrence per line
sed 's/old/new/g' file.txt         # -g: replace ALL occurrences
sed -i 's/foo/bar/g' config.txt    # -i: edit file in-place
sed '3d' file.txt                  # Delete line 3
sed '/^#/d' file.txt               # Delete all comment lines
sed -n '5,10p' file.txt            # Print only lines 5 to 10
sed 's/^/  /' file.txt             # Add indent to every line
```

### cut — Extract Columns

```bash
cut -d: -f1 /etc/passwd        # -d: delimiter, -f: field number
cut -d, -f1,3 data.csv         # Extract columns 1 and 3 from CSV
cut -c1-10 file.txt            # Extract characters 1 to 10
```

### sort — Sorting

```bash
sort file.txt              # Alphabetical (default)
sort -n numbers.txt        # -n: numerical sort
sort -r file.txt           # -r: reverse order
sort -u file.txt           # -u: unique (remove duplicates)
sort -t: -k3 -n /etc/passwd  # Sort by 3rd field, colon-delimited
```

### uniq — Deduplicate

```bash
sort file.txt | uniq          # Remove duplicate lines (must be sorted first)
sort file.txt | uniq -c       # -c: count occurrences
sort file.txt | uniq -d       # -d: show only duplicates
sort file.txt | uniq -u       # -u: show only unique lines
```

### tr — Translate/Delete Characters

```bash
echo "hello" | tr 'a-z' 'A-Z'    # Convert to uppercase
echo "hello world" | tr ' ' '_'  # Replace spaces with underscores
echo "abc123" | tr -d '0-9'      # -d: delete digits
echo "aabbcc" | tr -s 'a-z'      # -s: squeeze repeated chars
cat file.txt | tr -d '\r'         # Remove Windows carriage returns
```

### wc — Word/Line/Char Count

```bash
wc -l file.txt    # Count lines
wc -w file.txt    # Count words
wc -c file.txt    # Count bytes/characters
wc file.txt       # All three: lines, words, bytes
```

### head / tail

```bash
head -n 20 file.txt      # First 20 lines
tail -n 20 file.txt      # Last 20 lines
tail -f /var/log/syslog  # -f: follow — live stream new lines
tail -f app.log | grep "ERROR"   # Follow + filter
```

## 6. Useful Patterns and One-Liners

```bash
# 1. Find and delete files older than 7 days
find /var/log -name "*.log" -mtime +7 -delete

# 2. Count total lines across all .log files
cat *.log | wc -l
# Or, to see per-file counts:
wc -l *.log

# 3. Replace a string across multiple files
sed -i 's/localhost/production-db/g' config/*.conf

# 4. Check if a service is running
systemctl is-active --quiet nginx && echo "nginx is running" || echo "nginx is DOWN"

# 5. Monitor disk usage and alert if above 80%
USAGE=$(df / | awk 'NR==2 {print $5}' | tr -d '%')
[ "$USAGE" -gt 80 ] && echo "ALERT: Disk usage is ${USAGE}%"

# 6. Parse CSV — print second column
awk -F, '{print $2}' data.csv

# 7. Tail a log and filter for errors in real time
tail -f /var/log/app.log | grep --line-buffered "ERROR"

# 8. Show top 5 largest files in current directory
du -sh * | sort -rh | head -5

# 9. Extract unique IPs from a log file
grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}' access.log | sort -u

# 10. Archive and compress a directory with timestamp
tar -czf "backup_$(date +%Y%m%d_%H%M%S).tar.gz" /path/to/dir
```

## 7. Error Handling and Debugging

### Exit Codes

```bash
$?          # Exit code of last command (0 = success, non-zero = error)
exit 0      # Exit script successfully
exit 1      # Exit script with error

# Example
cp file.txt /backup/ || { echo "Copy failed!"; exit 1; }
```

### Strict Mode Flags

```bash
set -e            # Exit immediately if any command fails
set -u            # Treat unset variables as errors (no silent empty strings)
set -o pipefail   # Catch failures inside pipes (not just the last command)
set -x            # Debug/trace mode — prints each command before executing

# Best practice — put this at the top of every production script:
set -euo pipefail
```

```bash
# set -x example — shows exactly what's being executed
set -x
NAME="DevOps"
echo "Hello $NAME"
set +x    # Turn off debug mode
```

### trap — Cleanup on Exit

```bash
# Run cleanup() whenever the script exits (normally or on error)
cleanup() {
    echo "Cleaning up temp files..."
    rm -f /tmp/myapp_*
}
trap 'cleanup' EXIT

# Trap specific signals
trap 'echo "Script interrupted!"; exit 1' INT TERM

# Trap with line number for debugging
trap 'echo "Error on line $LINENO"' ERR
```

### Full Error-Handling Template

```bash
#!/bin/bash
set -euo pipefail

LOG="/var/log/myscript.log"

log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG"; }
error() { log "ERROR: $*" >&2; exit 1; }

cleanup() { log "Script finished. Cleaning up."; }
trap 'cleanup' EXIT
trap 'error "Unexpected failure on line $LINENO"' ERR

log "Script started"
# ... your code here ...
log "Script completed successfully"
```

## 📌 Tips to Remember

- Always quote your variables: **"$VAR"** not **$VAR** — prevents word splitting bugs.
- Use **[[ ]]** over **[ ]** for conditionals in bash — more powerful and safer.
- Prefer **$(command)** over backticks **`command`** — easier to nest and read.
- Use **local** inside functions to avoid polluting the global scope.
- Test scripts with **bash -n script.sh** (syntax check) before running.
- Use **shellcheck script.sh** for linting and catching common mistakes.
