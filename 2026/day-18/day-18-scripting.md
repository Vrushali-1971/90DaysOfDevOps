# Day 18 – Shell Scripting: Functions & Intermediate Concepts

## 🎯 Objective

In this task, I practiced writing cleaner and reusable Bash scripts by learning:

* vim Functions in shell scripting
* Strict mode using `set -euo pipefail`
* Local variables inside functions
* Building a practical system information script

---

# 🧪 Challenge Tasks

## Task 1 – Basic Functions

### Script: `functions.sh`

### Purpose

Create reusable functions to:

* greet a user
* add two numbers

### Code

```bash
#!/bin/bash

#greet function

 greet() {
         echo "Hello, $1!"
 }

 # add function

 add() {
         sum=$(($1 + $2))
         echo "The sum of two numbers is $sum"
 }

 greet $1
 add "$2" "$3"
```

### Output

- Command : ./functions.sh vrusahli 84 32

```
Hello, vrushali!
The sum of two numbers is 116
```

---

# Task 2 – Functions with Return Values

### Script: `disk_check.sh`

### Purpose

Use functions to check disk and memory usage.

### Code

```bash
#!/bin/bash

check_disk() {
    echo "Disk Usage:"
    df -h /
}

check_memory() {
    echo "Memory Usage:"
    free -h
}

main() {
    check_disk
    echo
    check_memory
}

main
```

### Output

```
------ Disk usage ------
Filesystem      Size  Used Avail Use% Mounted on
/dev/root        19G  3.1G   16G  17% /


------ Memory Usage -------
               total        used        free      shared  buff/cache   available
Mem:           911Mi       395Mi        92Mi       2.7Mi       581Mi       516Mi
Swap:             0B          0B          0B
```

---

# Task 3 – Strict Mode (`set -euo pipefail`)

### Script: `strict_demo.sh`

### Code

```bash
#!/bin/bash

 set -euo pipefail

 echo "Strict mode demo"

 # Test set -u (undefined variable)

 echo "Testing undefined variale:"

 echo "$undefined_var"

 # Test set -e (command failure)

 echo "Testing command failure:"
 false

 # Test pipefail

 echo "Testing pipe failure:"

  cat missingfile.txt | grep hello
```

---

### Explanation

* **set -e** → Exit the script immediately if a command fails.
* **set -u** → Exit if an undefined variable is used.
* **set -o pipefail** → If any command in a pipeline fails, the entire pipeline fails.

---

# Task 4 – Local Variables

### Script: `local_demo.sh`

### Purpose

Demonstrate how local variables behave differently from global variables.

### Code

```bash
#!/bin/bash

name="GlobalName"

use_local() {
    local name="LocalName"
    echo "Inside function (local): $name"
}

use_global() {
    name="ModifiedGlobal"
}

echo "Before function: $name"

use_local
echo "After local function: $name"
:wq
use_global
echo "After global function: $name"
```

### Output

```
Before function: GlobalName
Inside function (local): LocalName
After local function: GlobalName
After global function: ModifiedGlobal
```

### Explanation

Local variables exist only inside the function where they are declared, while regular variables modify the global value.

---

# Task 5 – System Info Reporter

### Script: `system_info.sh`

### Purpose

Build a script that reports system information using functions.

### Code

```bash
#!/bin/bash
set -euo pipefail

system_info() {
    echo "Hostname: $(hostname)"
    echo "OS Info: $(uname -a)"
}

uptime_info() {
    echo
    echo "Uptime:"
    uptime
}

disk_usage() {
    echo
    echo "Disk Usage:"
    df -h | head -5
}

memory_usage() {
    echo
    echo "Memory Usage:"
    free -h
}

cpu_processes() {
    echo
    echo "Top CPU Processes:"
    ps aux --sort=-%cpu | head -6
}

main() {
    echo "===== SYSTEM REPORT ====="
    system_info
    uptime_info
    disk_usage
    memory_usage
    cpu_processes
}

main
```

### Example Output

```
------ SYSTEM REPORT ------
Hostname: ip-172-31-30-185
OS Info: Linux ip-172-31-30-185 6.17.0-1007-aws #7~24.04.1-Ubuntu SMP Thu Jan 22 21:04:49 UTC 2026 x86_64 x86_64 x86_64 GNU/Linux

Uptime:
 12:08:33 up  2:03,  3 users,  load average: 0.04, 0.02, 0.00

Disk Usage:
Filesystem       Size  Used Avail Use% Mounted on
/dev/root         19G  3.1G   16G  17% /
tmpfs            456M     0  456M   0% /dev/shm
tmpfs            183M  908K  182M   1% /run
tmpfs            5.0M     0  5.0M   0% /run/lock

Memory Usage:
               total        used        free      shared  buff/cache   available
Mem:           911Mi       413Mi        74Mi       2.7Mi       582Mi       498Mi
Swap:             0B          0B          0B

Top CPU Processes:
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
ubuntu      1870  0.1  0.7  15004  7188 ?        S    11:24   0:03 sshd: ubuntu@pts/0
ubuntu      2039  0.0  0.7  15008  7192 ?        S    12:02   0:00 sshd: ubuntu@pts/2
root         589  0.0  5.0 1802132 47304 ?       Ssl  10:05   0:05 /usr/bin/containerd
root         544  0.0  4.1 1923400 38620 ?       Ssl  10:05   0:01 /snap/snapd/current/usr/lib/snapd/snapd
root         542  0.0  2.1 1830616 20200 ?       Ssl  10:05   0:01 /snap/amazon-ssm-agent/12322/amazon-ssm-agent
```
---

# 📚 Key Learnings

1. Functions make scripts reusable and easier to maintain.
2. Strict mode (`set -euo pipefail`) improves script reliability by stopping execution on errors.
3. Local variables help prevent accidental modification of global variables.

---

# 🚀 Conclusion

This exercise helped strengthen my Bash scripting skills by using functions, implementing strict error handling,

and building a modular system information reporting script.
