# Day 28: Revision Milestone (Days 1-27)

## 1. Self-Assessment Summary
- **Linux Fundamentals:** Confident.
- **LVM & Storage:** Confident after today's redo.
- **Shell Scripting:** Confident with loops and cron.
- **Git/GitHub CLI:** Good, but need to keep practicing Reset vs. Revert.

---

## 2. Topics Revisited (Task 2)
Today, I identified gaps in **LVM**, **Crontab**, and **GitHub CLI**. I performed the following:
- **LVM:** Created a virtual 1GB disk using `dd`, attached it as a loop device, and successfully set up Physical Volume, Volume Group, and Logical Volume layers. 
- **Cron:** Created a `heartbeat.sh` script to log timestamps and scheduled it to run every minute (`* * * * *`).
- **GitHub CLI:** Practiced `gh repo create` and `gh repo delete` to manage repositories directly from the terminal.

---

## 3. Quick-Fire Questions (Task 3)
1. **What does chmod 755 script.sh do?**
   - Sets permissions to `rwxr-xr-x`. Full access for owner, read/execute for group and others.
2. **What is the difference between a process and a service?**
   - A process is any running instance of a program; a service is a background process managed by the system (systemd), like SSH.
3. **How do you find which process is using port 8080?**
   - Use `ss -tulpn | grep 8080` or `netstat -plnt`. (The `-p` flag shows the PID/Program).
4. **What does set -euo pipefail do in a shell script?**
   - It is a "Strict Mode." It exits the script if a command fails (`-e`), a variable is undefined (`-u`), or a pipe command fails (`pipefail`).
5. **What is the difference between git reset --hard and git revert?**
   - `reset --hard` deletes history and moves the branch back (destructive); `revert` creates a new "fix" commit to undo changes (safe for teams).
6. **What branching strategy would you recommend for a team of 5 developers shipping weekly?**
   - GitHub Flow (Feature branches merged into Main via Pull Requests).
7. **What does git stash do and when would you use it?**
   - It temporarily "hides" uncommitted changes in a stack so you can switch branches with a clean workspace. Use `git stash pop` to get them back.
8. **How do you schedule a script to run every day at 3 AM?**
   - Cron entry: `0 3 * * * /path/to/script.sh`.
9. **What is the difference between git fetch and git pull?**
   - `fetch` only downloads the latest metadata from the remote; `pull` downloads AND merges those changes into your current local branch.
10. **What is LVM and why would you use it instead of regular partitions?**
    - Logical Volume Manager. It provides flexibility to resize, shrink, or combine multiple disks into one pool without data loss.

---

## 4. Teach It Back: Understanding Linux File Permissions (Task 5)

When you run the command `ls -l file.txt`, Linux shows you a string of characters that represent the "lock" on that file.

### Reading the Permissions
A typical output looks like this:
* **For a Directory:** `drwxrwxr-x` (The `d` at the beginning stands for Directory)
* **For a File:** `-rwxrwxr-x` (The `-` at the beginning means it is a regular file)

The next 9 characters are broken into three sets of three:
1. **User (Owner):** `rwx` (Read, Write, Execute)
2. **Group:** `rwx` (Read, Write, Execute)
3. **Others:** `r-x` (Read and Execute, but no Write)

### How to Change Permissions (chmod)
To change these "locks," we use the `chmod` (Change Mode) command. There are two main ways to do this:

**1. Numeric (Octal) Method**
We assign a number to each permission: **Read = 4**, **Write = 2**, and **Execute = 1**. 
By adding them together, we get a single digit for each category:
* **7 (4+2+1):** Full permissions (`rwx`)
* **6 (4+2+0):** Read and Write (`rw-`)
* **5 (4+0+1):** Read and Execute (`r-x`)
* **4 (4+0+0):** Read only (`r--`)

*Example:* `chmod 765 file.txt` 
- **7 (Owner):** Can do everything.
- **6 (Group):** Can read and write.
- **5 (Others):** Can read and execute.

**2. Symbolic Method**
Instead of math, we use letters and symbols to "add" or "remove" specific keys:
- **u** (User), **g** (Group), **o** (Others), **a** (All)
- **+** (Add), **-** (Remove)
- **r** (Read), **w** (Write), **x** (Execute)

*Example:* `chmod +x script.sh` 
This adds the **Execute** permission to the file for everyone. It is a quick way to make a script runnable without calculating the whole numeric code.

---
*Revision Day Complete. System cleaned and lab environment detached.*
