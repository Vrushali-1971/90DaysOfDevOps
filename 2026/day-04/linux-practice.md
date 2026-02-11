# Day 04 – Linux Process, Service, and Log Inspection

## Goal
To understand how to inspect running processes, systemd services, logs, and follow a basic troubleshooting flow in Linux.


## Process Inspection

### Command: ps
Observation:
Displays the processes running in the current terminal session with basic details like PID, TTY, TIME, and CMD.


### Command: ps aux
Observation:
Shows all running processes along with CPU usage, memory usage, and command name.


### Command: top
Observation:
Displays live CPU and memory usage of running processes. SSHD and systemd are commonly seen as background services.


### Command: pgrep ssh
Observation:
Displays the process IDs of running SSH-related processes, helping confirm that the SSH service is running.


## systemd Service Inspection (Chosen Service: SSH)

### Command: systemctl status ssh
Observation:
Shows whether the SSH service is active or inactive. Displays service status, main PID, and recent logs. Confirms that SSH is managed by systemd.


### Command: systemctl list-units --type=service | grep ssh
Observation:
Displays the SSH service in the list of active systemd services, confirming that SSH is currently running.


## Log Inspection

### Command: journalctl -u ssh
Observation:
Displays all logs related to the SSH service, including service start events, authentication attempts, and connection activity.


### Command: journalctl -u ssh | tail -n 50
Observation:
Shows the most recent 50 log entries for the SSH service, helping to quickly analyze recent login attempts or errors.


## Troubleshooting Flow – SSH Service Issue

### Scenario:
Unable to connect to the server via SSH.

### Steps:
1. Check SSH service status using `systemctl status ssh`.
2. Verify SSH process is running using `pgrep ssh`.
3. Check recent SSH logs using `journalctl -u ssh | tail -n 50`.
4. Confirm SSH is listening on port 22 using `ss -tuln | grep :22`.

### Observation:
SSH service was running and listening on port 22. Logs showed successful connections, indicating no service failure.

## Summary
This task helped me understand how to inspect Linux processes, verify systemd services, analyze logs, and follow a structured troubleshooting approach.
