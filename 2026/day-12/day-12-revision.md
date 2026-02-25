## Day 12 – Breather & Revision (Days 01–11)

### Goal
Today's goal is to take a one-day pause to consolidate and review the fundamentals learned from Days 01–11.

### Processes & services:
# Day 12 – Breather & Revision (Days 01–11)

## Goal
Today's goal is to take a one-day pause to consolidate and review the fundamentals learned from Days 01–11.

---

## Processes & Services Review

`ps`

**Observation:**  
The `ps` command displays the list of running processes in the system. It shows details such as **PID (process ID), user, CPU usage, memory usage, and the command that started the process**.

`sudo systemctl status nginx`

**Observation:**  
The command `sudo systemctl status nginx` shows the **current status of the Nginx service**. It displays whether the service is **active, inactive, or failed**, along with details like **PID, uptime, and recent log messages**.

---

## File Skills Practice
```bash
echo "Revision Day" > revision.txt
````
**Observation:**
Created a new file revision.txt and wrote initial content using the echo command.

```bash
echo "Let's revise previous topics today" >> revision.txt
```
**Observation:**
Appended text to revision.txt without overwriting the previous content

```bash
cat revision.txt
```
**Observation:**
Displayed the contents of the file revision.txt.

### Ownership & Permission Practice

```bash
chmod 444 revision.txt
```
**Observation:** 
Changed file permissions to read-only for owner, group, and others.

```bash
 echo "Let's write something to read only file" >> revision.txt
```
**Observation:** 
Attempted to write to a read-only file and received Permission denied, confirming the permission change worked

```bash
sudo useradd vrush
```
**Observation:**
Created a new user named vrush.

```bash
sudo chown vrush revision.txt
```
**Observation:** 
Changed file ownership from ubuntu to vrush.

```bash
sudo groupadd tokyo
```
**Observation:**
Created a new group named tokyo.

```bash
sudo chgrp tokyo revision.txt
```
**Observation:** 
Changed the group ownership of the file from ubuntu to tokyo.

```bash
ls -l revision.txt
```
**Observation:** 
Verified file ownership and permissions

**Before** 

-rw-rw-r-- 

Owner - read and write

Group - read and write 

Others- read-only 

**After** 

-r--r--r--

read-only permission to all owner, group and others

### Commands I Would Use First in an Incident

top – Shows live CPU and memory usage to quickly identify high resource-consuming processes.

ps aux – Displays all running processes with details like CPU, memory usage, and PID.

df -h – Checks disk space usage in human-readable format.

ss -tuln – Lists active listening ports and services to verify if required services are running.

ping – Tests network connectivity to check if the system can reach other hosts.

These commands help quickly diagnose issues related to CPU usage, running processes, disk space, service ports,
and network connectivity during an incident.

### Mini Self-Check 

1. Which 3 commands save you the most time right now, and why?

  As a beginner learning Linux and DevOps, I haven’t handled real incidents yet.
  However, these commands helped me the most during practice..
 
- tmux (session management) – Helps me keep terminal sessions running even if my SSH connection disconnects. This prevents losing work on remote servers.

- pwd – Shows the current working directory, helping me confirm I am in the correct location before creating, copying, or modifying files.

- systemctl status <service> – Allows me to quickly check if a service is installed, running, or enabled, and view its current status

2. How do you check if a service is healthy? List the 2–3 commands you’d run first.
```bash
sudo systemctl status nginx
ps aux | grep nginx
ss -tuln
```
These commands check the service status, running processes, and listening ports.

3. How do you safely change ownership and permissions without breaking access?

Example command:
```bash
sudo chown user:group filename
```

Example:
```bash
sudo chown tokyo:developers devops.txt
```
This changes the file owner and group while maintaining controlled access.

4. What will you focus on improving in the next 3 days?

- Practicing Linux file permissions and ownership management.

- Learning more system troubleshooting commands.

- Improving hands-on practice with services and process monitoring.

## Key Takeaways

- Reinforced understanding of Linux processes and service monitoring.
- Practiced file operations, permissions, and ownership management.
- Improved confidence in using basic Linux commands for troubleshooting.









