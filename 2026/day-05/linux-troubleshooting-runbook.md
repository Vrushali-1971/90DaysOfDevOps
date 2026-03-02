## Day 05 – Linux Troubleshooting Drill: CPU, Memory, and Logs

### Target Service / Process

Service inspected: SSH (OpenSSH Server)

The goal of this runbook is to capture a quick health snapshot of the system and review logs related to the SSH service.

### 1. Environment Basics

**Check Kernel Information**

```bash
uname -a
```

**Snapshot**

`Linux ip-172-31-26-117 6.14.0-1018-aws #18~24.04.1-Ubuntu SMP Mon Nov 24 19:46:27 UTC 2025 x86_64 GNU/Linux`

**Observation**

The system is running Ubuntu kernel 6.14 on AWS infrastructure.

**Check Operating System**

```bash
cat /etc/os-release
```

**Snapshot**

```
PRETTY_NAME="Ubuntu 24.04.3 LTS"
NAME="Ubuntu"
VERSION="24.04.3 LTS (Noble Numbat)"
VERSION_ID="24.04"
ID=ubuntu
```

**Observation**

The server is running Ubuntu 24.04 LTS, which is a stable long-term support release.

### 2. Filesystem Sanity Check

**Create Test Directory**

```bash
mkdir /tmp/runbook-demo
cd /tmp
ls
```
**Snapshot**

```
runbook-demo
systemd-private-xxxx
```

**Observation**

Created a temporary directory to perform file operations.

**Copy System File**

```bash
cp /etc/hosts /tmp/runbook-demo/hosts-copy
ls -l /tmp/runbook-demo
```

**Snapshot**

`-rw-r--r-- 1 ubuntu ubuntu 221 Feb 5 17:23 hosts-copy`

**Observation**

The hosts file was successfully copied to the test directory.

**Verify File Content**

```bash
cat /tmp/runbook-demo/hosts-copy
```

**Snapshot**

```
127.0.0.1 localhost
::1 localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
```

**Observation**

File contents were copied correctly.

### 3. CPU and Memory Snapshot

**Check System Processes**

```bash
top
```

**Snapshot**

```
Tasks: 118 total, 1 running, 117 sleeping
%Cpu(s): 0.0 us, 4.5 sy, 90.9 id
MiB Mem : 914.2 total, 377.0 free, 348.8 used
```

**Observation**

CPU usage is low and the system is mostly idle.

**Check Specific Process**

```bash
ps -o pid,pcpu,pmem,comm -p 915
```

**Snapshot**

```
PID %CPU %MEM COMMAND
915 0.0 0.8 sshd
```

**Observation**

The SSH daemon process (sshd) is running and consuming minimal resources.

**Check Memory Usage**

```bash
free -h
```

**Snapshot**

```
Mem: 914Mi total
344Mi used
348Mi free
569Mi available
Swap: 0B
```

**Observation**

The system has sufficient free memory and no swap usage.

### 4. Disk and IO Snapshot

**Check Disk Space**
```bash
df -h
```

**Snapshot**

```
Filesystem      Size  Used Avail Use%
/dev/root       6.8G  2.3G  4.5G  34%
```

**Observation**

Disk usage is around 34%, so there is plenty of available storage.

**Check Log Directory Size**

```bash
sudo du -sh /var/log
```

**Snapshot**

`106M /var/log`

**Observation**

Log directory size is moderate and not consuming excessive space.

### 5. Network Snapshot

**Check Listening Ports**

```bash
ss -tuln
```

**Snapshot**

```
tcp LISTEN 0 4096 0.0.0.0:22
tcp LISTEN 0 511 127.0.0.1:631
tcp LISTEN 0 4096 127.0.0.53:53
```

**Observation**

SSH service is listening on port 22, confirming it is active.

### 6. Logs Review

**Check SSH Logs**

```bash
journalctl -u ssh -n 50
```

**Snapshot**

```
Started ssh.service - OpenBSD Secure Shell server.
Accepted publickey for ubuntu from 18.202.xxx.xxx port 53137 ssh2
```

**Observation**

Logs confirm that the SSH service started successfully and accepted login connections.

### Quick Findings

SSH service is running normally.

CPU usage is low and stable.

Memory usage is within safe limits.

Disk space is sufficient.

SSH logs show successful authentication attempts.

No performance or service issues were detected.

### If This Worsens (Next Steps)

If SSH becomes slow or inaccessible:

1. Restart the SSH service

```bash
sudo systemctl restart ssh
```

2. Check system resources

```bash
top
free -h
df -h
```

3. Investigate SSH logs for errors

```bash
journalctl -u ssh -n 100
```

**Commands Used**

```bash
uname -a
cat /etc/os-release
mkdir /tmp/runbook-demo
cp /etc/hosts /tmp/runbook-demo/hosts-copy
ls -l
cat hosts-copy
top
ps -o pid,pcpu,pmem,comm
free -h
df -h
du -sh /var/log
ss -tuln
journalctl -u ssh -n 50
```
